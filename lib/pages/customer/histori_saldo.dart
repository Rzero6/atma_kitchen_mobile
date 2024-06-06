import 'package:atma_kitchen_mobile/api/histori_client.dart';
import 'package:atma_kitchen_mobile/api/user_client.dart';
import 'package:atma_kitchen_mobile/model/customer.dart';
import 'package:atma_kitchen_mobile/model/histori.dart';
import 'package:atma_kitchen_mobile/pages/customer/ajukan_tarik_saldo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriSaldoPage extends ConsumerStatefulWidget {
  const HistoriSaldoPage({super.key});

  @override
  ConsumerState<HistoriSaldoPage> createState() => _HistoriSaldoState();
}

class _HistoriSaldoState extends ConsumerState<HistoriSaldoPage> {
  int idCustomer = 0;
  bool loading = true;
  final listHistoriSaldoProvider =
      FutureProvider.family<List<HistoriSaldo>?, String>((ref, id) async {
    List<HistoriSaldo>? items = await HistoriSaldoClient.getAllHistoriSaldo();
    items = items
        .where((item) => item.status && item.idCustomer == int.parse(id))
        .toList();
    return items;
  });
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    int idUser = sharedPrefs.getInt("userID") ?? 0;
    Customer customer = await UserClient().getUser(idUser);
    idCustomer = customer.id!;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var itemListener =
        ref.watch(listHistoriSaldoProvider(idCustomer.toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saldo"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(6.h)),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const TarikSaldo()))
                          },
                      child: const Text("Ajukan tarik Saldo")),
                ),
                Expanded(
                  child: itemListener.when(
                    data: (data) {
                      if (data != null && data.isNotEmpty) {
                        data = data.reversed.toList();
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              color: data![index].buktiTransfer == "ditolak"
                                  ? const Color.fromARGB(81, 255, 82, 90)
                                  : const Color.fromARGB(100, 105, 240, 90),
                              child: ListTile(
                                leading: SizedBox(
                                  width: 16.w,
                                  child: data[index].buktiTransfer == "ditolak"
                                      ? const Text("Ditolak")
                                      : const Text("Ditransfer"),
                                ),
                                subtitle: Text(DateFormat('HH:mm, dd MMMM yyyy')
                                    .format(
                                        DateTime.parse(data[index].updateAt!)
                                            .toLocal())),
                                title: Text(data[index].tujuan),
                                trailing: Text(
                                  data[index].mutasi < 0
                                      ? "-Rp. ${data[index].mutasi.abs().toString()}"
                                      : "+Rp. ${data[index].mutasi.toString()}",
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("Tidak ada data"),
                        );
                      }
                    },
                    error: (err, s) {
                      return Center(
                        child: Text(err.toString()),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
