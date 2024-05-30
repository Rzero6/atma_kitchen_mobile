import 'package:atma_kitchen_mobile/model/produk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProdukDetails extends StatefulWidget {
  final Produk produk;
  const ProdukDetails({Key? key, required this.produk}) : super(key: key);

  @override
  State<ProdukDetails> createState() => _ProdukDetailsState();
}

class _ProdukDetailsState extends State<ProdukDetails> {
  @override
  Widget build(BuildContext context) {
    final Produk produk = widget.produk;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atma Kitchen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(0.w),
              child: produk.image == null
                  ? Image.asset(
                      "assets/image/pastry.jpg",
                      height: 30.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    )
                  : Image.network(produk.image!),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Text(
                produk.nama,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.h),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Text(
                produk.ukuran,
                textAlign: TextAlign.end,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Text(
                "Rp. ${NumberFormat("#,##0", "id_ID").format(produk.harga)}",
                textAlign: TextAlign.end,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Text(
                "Tersisa ${produk.stok}",
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
