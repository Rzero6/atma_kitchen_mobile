import 'package:atma_kitchen_mobile/api/presensi_client.dart';
import 'package:atma_kitchen_mobile/model/presensi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EditPresensiPage extends ConsumerStatefulWidget {
  const EditPresensiPage({super.key});

  @override
  ConsumerState<EditPresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends ConsumerState<EditPresensiPage> {
  final TextEditingController _searchController = TextEditingController();
  bool loading = false;
  String tanggal = "";
  final listPresensiProvider =
      FutureProvider.family<List<Presensi>?, String>((ref, search) async {
    List<Presensi>? items = await PresensiClient.getPresensisHariIni();
    if (items.isNotEmpty) {
      return items;
    } else {
      return null;
    }
  });
  bool value = true;
  @override
  void initState() {
    super.initState();
    _searchController.text = "";
  }

  Future<bool> updatePresensi(List<Presensi> presensiList) async {
    bool success = false;
    for (Presensi presensi in presensiList) {
      if (presensi.kehadiran != presensi.kehadiranOri) {
        success = await PresensiClient.updatePresensisHariIni(presensi.id!);
        if (!success) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var itemListener = ref.watch(listPresensiProvider(_searchController.text));
    final BuildContext pageContext = context;
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Presensi ${DateFormat('EEE, d MMM yyyy').format(DateTime.now())}")),
      body: Container(
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Konfirmasi"),
                content: const Text("Simpan presensi hari ini?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Batal"),
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      Navigator.of(context).pop();
                      bool response =
                          await updatePresensi(itemListener.asData!.value!);
                      if (response) {
                        const SnackBar(content: Text('Berhasil simpan data'));
                        Navigator.of(pageContext).pop();
                      } else {
                        const SnackBar(
                            content:
                                Text('Gagal simpan data, cek jaringa anda'));
                      }
                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Text("Simpan"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.save_sharp),
      ),
    );
  }
}
