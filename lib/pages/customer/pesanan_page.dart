import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import 'package:atma_kitchen_mobile/model/transaksi.dart';
import 'package:atma_kitchen_mobile/api/transaksi_client.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PesananPage extends ConsumerStatefulWidget {
  const PesananPage({super.key});

  @override
  ConsumerState<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends ConsumerState<PesananPage> {
  final TextEditingController _controller = TextEditingController();
  final listTransactionProvider =
      FutureProvider.family<List<Transaksi>?, String>((ref, search) async {
    List<Transaksi>? items = await TransaksiClient.getTransaksisPerUser();
    if (items.isNotEmpty) {
      List<Transaksi> filteredItems =
          items.where((element) => element.status == search).toList();

      return filteredItems;
    } else {
      return null;
    }
  });
  List<String> status = ["diproses", "pickup", "pengiriman", "selesai"];

  @override
  void initState() {
    _controller.text = status[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var itemListener = ref.watch(listTransactionProvider(_controller.text));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
      ),
      body: Column(
        children: [
          NavigationView(
            onChangePage: (c) {
              switch (c) {
                case 0:
                  setState(() {
                    _controller.text = status[c];
                  });
                  break;
                case 1:
                  setState(() {
                    _controller.text = status[c];
                  });
                  break;
                case 2:
                  setState(() {
                    _controller.text = status[c];
                  });
                  break;
                case 3:
                  setState(() {
                    _controller.text = status[c];
                  });
                  break;
              }
            },
            curve: Curves.easeIn,
            durationAnimation: const Duration(milliseconds: 400),
            items: [
              ItemNavigationView(
                childAfter: const Text('Diproses',
                    style: TextStyle(color: Colors.blue)),
                childBefore: Text('Diproses',
                    style: TextStyle(color: Colors.grey.withAlpha(60))),
              ),
              ItemNavigationView(
                childAfter: const Text('Siap Pick-up',
                    style: TextStyle(color: Colors.blue)),
                childBefore: Text('Siap Pick-up',
                    style: TextStyle(color: Colors.grey.withAlpha(60))),
              ),
              ItemNavigationView(
                childAfter: const Text('Perjalanan',
                    style: TextStyle(color: Colors.blue)),
                childBefore: Text('Perjalanan',
                    style: TextStyle(color: Colors.grey.withAlpha(60))),
              ),
              ItemNavigationView(
                childAfter:
                    const Text('Selesai', style: TextStyle(color: Colors.blue)),
                childBefore: Text('Selesai',
                    style: TextStyle(color: Colors.grey.withAlpha(60))),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: itemListener.when(
              data: (data) {
                if (data != null && data.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        height: 13.h,
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(DateFormat('EEEE, d MMM yyyy').format(
                                  DateTime.parse(
                                      data[index].tanggalPenerimaan))),
                              Text(
                                  'Alamat: ${data[index].alamat!.jalan}, ${data[index].alamat!.kota}'),
                              Text(
                                  'Penerima: ${data[index].alamat!.namaPenerima}'),
                              Text(
                                'Barang yang dibeli: ${data[index].detailTransaksi!.map((adetail) => adetail.produk != null ? adetail.produk!.nama : adetail.hampers!.nama).join(", ")}',
                              ),
                              Text(
                                'Total Pembayaran: ${data[index].detailTransaksi!.fold<double>(0, (total, adetail) => total + (adetail.produk != null ? adetail.produk!.harga * adetail.jumlah : 0) + (adetail.hampers != null ? adetail.hampers!.harga * adetail.jumlah : 0)) + data[index].tip}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: data.length,
                  );
                } else {
                  return const Center(child: Text('No data available.'));
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
          ),
        ],
      ),
    );
  }
}
