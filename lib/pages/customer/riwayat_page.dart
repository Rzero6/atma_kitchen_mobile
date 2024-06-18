import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import 'package:atma_kitchen_mobile/model/transaksi.dart';
import 'package:atma_kitchen_mobile/api/transaksi_client.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RiwayatPage extends ConsumerStatefulWidget {
  const RiwayatPage({super.key});

  @override
  ConsumerState<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends ConsumerState<RiwayatPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> stringList = [];
  final listTransactionProvider =
      FutureProvider.family<List<Transaksi>?, String>((ref, search) async {
    List<Transaksi>? items = await TransaksiClient.getTransaksisPerUser();
    List<String> queryTerms = search.toLowerCase().split(" ").toList();
    List<Transaksi> result = items.where((atransaksi) {
      return queryTerms.every((queryTerm) {
        return atransaksi.detailTransaksi!.any((adetail) {
          String productName = adetail.produk?.nama.toLowerCase() ?? "";
          String hamperName = adetail.hampers?.nama.toLowerCase() ?? "";
          return productName.contains(queryTerm) ||
              hamperName.contains(queryTerm);
        });
      });
    }).toList();
    return result;
  });

  @override
  void initState() {
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
            ),
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
                              Text(
                                DateFormat('EEEE, d MMM yyyy').format(
                                  DateTime.parse(data[index].tanggalPenerimaan),
                                ),
                              ),
                              data[index].alamat != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Alamat: ${data[index].alamat!.jalan}, ${data[index].alamat!.kota}',
                                        ),
                                        Text(
                                          'Penerima: ${data[index].alamat!.namaPenerima}',
                                        ),
                                      ],
                                    )
                                  : const Text('Di pick-up'),
                              Text(
                                'Barang yang dibeli: ${data[index].detailTransaksi!.map((adetail) => adetail.produk != null ? adetail.produk!.nama : adetail.hampers!.nama).join(", ")}',
                              ),
                              Text(
                                'Total Pembayaran: ${data[index].totalHarga}',
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
