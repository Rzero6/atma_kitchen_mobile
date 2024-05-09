import 'package:atma_kitchen_mobile/pages/customer/goto_login.dart';
import 'package:atma_kitchen_mobile/pages/customer/produk_page.dart';
import 'package:atma_kitchen_mobile/pages/customer/riwayat_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:atma_kitchen_mobile/pages/customer/home_page.dart';
import 'package:atma_kitchen_mobile/pages/customer/settings_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  var currentPageIndex = 0;
  bool isLoggedIn = false;
  void onNavBarTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    checking();
  }

  void checking() async {
    bool loggedIn = await checkLogin();
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const ProdukPage(),
      isLoggedIn ? const RiwayatPage() : const GoToLoginPage(),
      const SettingsPage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: pages[currentPageIndex],
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.w),
            child: GNav(
              gap: 8,
              tabBackgroundColor: Colors.blue.shade300,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(icon: Icons.home, text: 'Utama'),
                GButton(
                  icon: Icons.bakery_dining,
                  text: 'Produk',
                  iconSize: 30,
                ),
                GButton(
                  icon: Icons.history,
                  text: 'Riwayat',
                ),
                GButton(
                  icon: Icons.settings_rounded,
                  text: 'Pengaturan',
                ),
              ],
              duration: const Duration(milliseconds: 500),
              selectedIndex: currentPageIndex,
              activeColor: Colors.white,
              color: Colors.white,
              onTabChange: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> checkLogin() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String? username = sharedPrefs.getString('username');
  return username != null && username.isNotEmpty;
}
