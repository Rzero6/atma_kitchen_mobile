import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           OrderListView(false, data[index].id),
                        //     ));
                      },
                      child: SizedBox(
                        height: 8.h,
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index].alamat!.namaPenerima),
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
