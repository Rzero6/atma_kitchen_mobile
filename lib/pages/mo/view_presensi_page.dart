import 'package:atma_kitchen_mobile/api/presensi_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atma_kitchen_mobile/model/presensi.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class ViewPresensiPage extends ConsumerStatefulWidget {
  const ViewPresensiPage({super.key});

  @override
  ConsumerState<ViewPresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends ConsumerState<ViewPresensiPage> {
  final TextEditingController dateController = TextEditingController();
  bool loading = false;
  final listPresensiProvider =
      FutureProvider.family<List<Presensi>?, String>((ref, search) async {
    List<Presensi>? items = await PresensiClient.getAllPresensi();

    List<Presensi>? result =
        items.where((element) => element.tanggal == search).toList();
    if (items.isNotEmpty) {
      return result;
    } else {
      return null;
    }
  });
  bool value = true;
  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var itemListener = ref.watch(listPresensiProvider(dateController.text));
    return Scaffold(
      appBar: AppBar(title: const Text("Presensi")),
      body: Container(
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    TextFormField(
                        key: const Key("register-input-date"),
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        onTap: _selectDate,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: const Icon(Icons.date_range),
                          labelText: 'Tanggal Presensi',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _selectDate();
                            },
                            icon: const Icon(Icons.date_range_outlined),
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Masukan Tanggal Lahir';
                          }
                          // if (under18(value)) {
                          //   return 'Please Get Older (18+)';
                          // }
                          return null;
                        }),
                    SizedBox(height: 3.h),
                    Expanded(
                      child: itemListener.when(
                        data: (data) {
                          if (data != null && data.isNotEmpty) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                if (data[index].role.toLowerCase() != "owner") {
                                  return CheckboxListTile(
                                    title: Text(data[index].user.name),
                                    subtitle: Text(data[index].role),
                                    value: data[index].kehadiran,
                                    onChanged: (newValue) {
                                      setState(() {
                                        data[index].kehadiran = newValue!;
                                      });
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No data available.'),
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
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dateController.text =
            DateFormat('yyyy-MM-dd').format(picked).toString().split(" ")[0];
      });
    }
  }
}
