import 'package:atma_kitchen_mobile/api/api_client.dart';
import 'package:atma_kitchen_mobile/api/hampers_client.dart';
import 'package:atma_kitchen_mobile/api/produk_client.dart';
import 'package:atma_kitchen_mobile/model/hampers.dart';
import 'package:atma_kitchen_mobile/model/produk.dart';
import 'package:atma_kitchen_mobile/pages/customer/hampers_details.dart';
import 'package:atma_kitchen_mobile/pages/customer/produk_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProdukPage extends ConsumerStatefulWidget {
  const ProdukPage({super.key});

  @override
  ConsumerState<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends ConsumerState<ProdukPage> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool loading = false;
  final listProdukProvider =
      FutureProvider.family<List<Produk>?, String>((ref, search) async {
    List<Produk>? items = await ProdukClient.getAllProduk();
    items = items
        .where((produk) => produk.nama.toLowerCase().contains(search))
        .toList();
    return items;
  });
  final listHampersProvider =
      FutureProvider.family<List<Hampers>?, String>((ref, search) async {
    List<Hampers>? items = await HampersClient.getAllHampers();
    items = items
        .where((hampers) =>
            search.toLowerCase().contains("hampers") ||
            hampers.detailHampers!.any((detail) =>
                detail.produk != null &&
                (detail.produk!.nama
                        .toLowerCase()
                        .contains(search.toLowerCase()) ||
                    hampers.nama.toLowerCase().contains(search.toLowerCase()))))
        .toList();
    return items;
  });

  @override
  Widget build(BuildContext parentContext) {
    var produkListener = ref.watch(listProdukProvider(searchController.text));
    var hampersListener = ref.watch(listHampersProvider(searchController.text));

    bool produkLoading = produkListener.when(
      loading: () => true,
      data: (_) => false,
      error: (_, __) => false,
    );

    bool hampersLoading = hampersListener.when(
      loading: () => true,
      data: (_) => false,
      error: (_, __) => false,
    );
    bool loading = produkLoading || hampersLoading;
    int produkCount = produkListener.when(
      data: (data) => data?.length ?? 0,
      loading: () => 0,
      error: (err, stack) => 0,
    );
    int hampersCount = hampersListener.when(
      data: (data) => data?.length ?? 0,
      loading: () => 0,
      error: (err, stack) => 0,
    );
    int count = hampersCount + produkCount;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 0.5.w,
              right: 0.5.w,
              top: 2.h,
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari Produk...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchController.text = "";
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : count == 0
                    ? const Center(
                        child: Text("Tidak ada Produk"),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            produkListener.when(
                              data: (data) {
                                if (data != null && data.isNotEmpty) {
                                  return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5),
                                    itemCount: data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                            parentContext,
                                            MaterialPageRoute(
                                                builder: (_) => ProdukDetails(
                                                    produk: data[index]))),
                                        child: Card(
                                          child: Column(
                                            children: [
                                              data[index].image != null
                                                  ? Image.network(
                                                      ApiClient().produk +
                                                          data[index].image!)
                                                  : Image.asset(
                                                      'assets/image/pastry.jpg'),
                                              Padding(
                                                padding: EdgeInsets.all(1.h),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      data[index].nama,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Rp. ${NumberFormat("#,##0", "id_ID").format(data[index].harga)}",
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center();
                                }
                              },
                              error: (err, s) {
                                return Center(
                                  child: Text(err.toString()),
                                );
                              },
                              loading: () => const Center(),
                            ),
                            hampersListener.when(
                              data: (data) {
                                if (data != null && data.isNotEmpty) {
                                  return GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5),
                                    itemCount: data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                            parentContext,
                                            MaterialPageRoute(
                                                builder: (_) => HampersDetails(
                                                    hampers: data[index]))),
                                        child: Card(
                                          child: Column(
                                            children: [
                                              data[index].image != null
                                                  ? Image.network(
                                                      ApiClient().produk +
                                                          data[index].image!)
                                                  : Image.asset(
                                                      'assets/image/pastry.jpg'),
                                              Padding(
                                                padding: EdgeInsets.all(1.h),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      data[index].nama,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "Rp. ${NumberFormat("#,##0", "id_ID").format(data[index].harga)}",
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center();
                                }
                              },
                              error: (err, s) {
                                return Center(
                                  child: Text(err.toString()),
                                );
                              },
                              loading: () => const Center(),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
