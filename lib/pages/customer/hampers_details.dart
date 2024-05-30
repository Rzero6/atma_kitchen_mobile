import 'package:atma_kitchen_mobile/model/hampers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HampersDetails extends StatefulWidget {
  final Hampers hampers;
  const HampersDetails({Key? key, required this.hampers}) : super(key: key);

  @override
  State<HampersDetails> createState() => _HampersDetailsState();
}

class _HampersDetailsState extends State<HampersDetails> {
  @override
  Widget build(BuildContext context) {
    final Hampers hampers = widget.hampers;
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
              child: hampers.image == null
                  ? Image.asset(
                      "assets/image/pastry.jpg",
                      height: 30.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    )
                  : Image.network(hampers.image!),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Text(
                hampers.nama,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.h),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: Text(
                "Rp. ${NumberFormat("#,##0", "id_ID").format(hampers.harga)}",
                textAlign: TextAlign.end,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: hampers.detailHampers!.length,
                itemBuilder: (context, index) {
                  return Text(hampers.detailHampers![index].produk == null
                      ? ("${hampers.detailHampers![index].jumlah} ${hampers.detailHampers![index].bahanBaku!.nama}")
                      : ("${hampers.detailHampers![index].jumlah} ${hampers.detailHampers![index].produk!.nama}"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
