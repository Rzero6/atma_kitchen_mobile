import 'package:atma_kitchen_mobile/model/customer.dart';
import 'package:atma_kitchen_mobile/pages/customer/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:atma_kitchen_mobile/api/api_client.dart';
import 'package:atma_kitchen_mobile/pages/login_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atma_kitchen_mobile/api/user_client.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? userID;
  Customer? userData;
  bool isLoading = true;
  bool isLoggedIn = false;
  final UserClient _userClient = UserClient();
  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext pageContext = context;
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  if (isLoggedIn) ...[
                    const SizedBox(
                      height: 25,
                    ),
                    profilePicWidget(),
                    const SizedBox(
                      height: 24,
                    ),
                    profileNameWidget(),
                  ],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: additionalMenu(pageContext, isLoggedIn),
                  ),
                ],
              ));
  }

  Future<void> loadData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? username = sharedPrefs.getString('username') ?? "";
    isLoggedIn = username.isNotEmpty;
    if (isLoggedIn) {
      userData = await _userClient.getUser(
          sharedPrefs.getString('token')!, sharedPrefs.getInt('userID')!);
    }
    setState(() {
      isLoading = false;
    });
  }

  Center profilePicWidget() {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Hero(
                tag: 'profilePic',
                child: userData?.profilPic != null
                    ? Ink.image(
                        image: Image.network(
                          '${ApiClient().pic}${userData!.profilPic}',
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 128,
                            );
                          },
                        ).image,
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128,
                      )
                    : Initicon(text: userData!.user!.name, size: 128),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()));
              },
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  color: Theme.of(context).colorScheme.primary,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column profileNameWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userData?.user!.name ?? "Not Found",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          userData?.user!.email ?? "Not Found",
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Column additionalMenu(pageContext, isLoggedIn) {
    return Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Theme(
                    data: ThemeData(highlightColor: Colors.transparent),
                    child: isLoggedIn
                        ? ListTile(
                            splashColor: Colors.transparent,
                            leading:
                                const Icon(Icons.logout, color: Colors.red),
                            title: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Logout'),
                                    content: const Text('Yakin ingin keluar ?'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.red)),
                                          onPressed: () {
                                            removeLoginData();
                                            Navigator.of(context).pop();
                                            Navigator.pushReplacement(
                                                pageContext,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const Loginview()));
                                          },
                                          child: const Text('Logout'))
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : ListTile(
                            splashColor: Colors.transparent,
                            leading:
                                const Icon(Icons.login, color: Colors.blue),
                            title: const Text(
                              'Login',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Loginview())),
                          )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> removeLoginData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();
  }
}
