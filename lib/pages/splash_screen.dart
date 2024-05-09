import 'package:atma_kitchen_mobile/pages/mo/mo_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:atma_kitchen_mobile/pages/customer/main_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), nextPage);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bakery_dining,
                size: 80,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Atma Kitchen',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 32),
              )
            ]),
      ),
    );
  }

  Future<Widget> checkLogin() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String username = sharedPrefs.getString('username') ?? "";
    int idRole = sharedPrefs.getInt('roleID') ?? 0;
    if (username.isNotEmpty && idRole == 2) {
      return const MOMenuPage();
    } else {
      return const MainMenuView();
    }
  }

  Future<void> nextPage() async {
    Widget nextScreen = await checkLogin();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));
  }
}
