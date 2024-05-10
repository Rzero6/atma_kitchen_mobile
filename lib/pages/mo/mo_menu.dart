import 'package:atma_kitchen_mobile/pages/login_page.dart';
import 'package:atma_kitchen_mobile/pages/mo/edit_presensi_page.dart';
import 'package:atma_kitchen_mobile/pages/mo/view_presensi_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MOMenuPage extends StatefulWidget {
  const MOMenuPage({super.key});

  @override
  State<MOMenuPage> createState() => _MOMenuPageState();
}

class _MOMenuPageState extends State<MOMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manager Operasional'),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              removeLoginData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const Loginview()));
            },
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.list_alt,
                ),
                title: const Text('Ubah Presensi'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const EditPresensiPage())),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.list_alt,
                ),
                title: const Text('Lihat Presensi'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ViewPresensiPage())),
              ),
              const Divider(),
            ],
          ),
        ));
  }

  Future<void> removeLoginData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();
  }
}
