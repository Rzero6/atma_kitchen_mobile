import 'package:atma_kitchen_mobile/api/histori_client.dart';
import 'package:atma_kitchen_mobile/api/user_client.dart';
import 'package:atma_kitchen_mobile/model/customer.dart';
import 'package:atma_kitchen_mobile/model/histori.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarikSaldo extends StatefulWidget {
  const TarikSaldo({super.key});

  @override
  State<TarikSaldo> createState() => _TarikSaldoState();
}

class _TarikSaldoState extends State<TarikSaldo> {
  int idCustomer = 0;
  Customer? customer;
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _tujuanController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    int idUser = sharedPrefs.getInt("userID") ?? 0;
    customer = await UserClient().getUser(idUser);
    setState(() {
      idCustomer = customer!.id!;
      isLoading = false;
    });
  }

  void sendData(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      bool success = await HistoriSaldoClient.createHistoriSaldo(HistoriSaldo(
        idCustomer: idCustomer,
        status: false,
        mutasi: -double.parse(_jumlahController.text),
        tujuan: _tujuanController.text,
      ));
      setState(() {
        isLoading = false;
      });
      if (success) {
        // Pop page and show snackbar on success
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Berhasil mengajukan.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Show snackbar on failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uh Oh, gagal.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show snackbar on error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Pengajuan"),
      ),
      body: Container(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Text(
                        'Saldo: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.').format(customer!.saldo)}',
                        style: TextStyle(fontSize: 3.h),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: TextFormField(
                        controller: _jumlahController,
                        validator: (value) {
                          double newValue = double.parse(value!);
                          return newValue > customer!.saldo
                              ? "Saldo tidak cukup"
                              : null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Masukan Jumlah',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: TextFormField(
                        controller: _tujuanController,
                        validator: (value) =>
                            value == '' ? 'Masukan Tujuan' : null,
                        decoration: const InputDecoration(
                            hintText: 'Masukan Tujuan',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: ElevatedButton(
                        onPressed: () => {
                          if (formKey.currentState!.validate())
                            {sendData(context)}
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(6.h)),
                        child: const Text("Kirim"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
