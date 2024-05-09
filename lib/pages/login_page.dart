import 'package:atma_kitchen_mobile/pages/mo/mo_menu.dart';
import 'package:atma_kitchen_mobile/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atma_kitchen_mobile/bloc/form_submission_state.dart';
import 'package:atma_kitchen_mobile/bloc/login_bloc.dart';
import 'package:atma_kitchen_mobile/bloc/login_event.dart';
import 'package:atma_kitchen_mobile/bloc/login_state.dart';
import 'package:atma_kitchen_mobile/model/user.dart';
import 'package:atma_kitchen_mobile/pages/customer/main_menu.dart';
import 'package:atma_kitchen_mobile/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state.formSubmissionState is SubmissionSuccess) {
            User userData =
                (state.formSubmissionState as SubmissionSuccess).user;
            await saveLoginData(userData);
            if (userData.idRole == 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login Berhasil! Heloo ${userData.name}'),
                ),
              );
              Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const MainMenuView()),
                  (route) => false);
            } else if (userData.idRole == 2) {
              Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const MOMenuPage()),
                  (route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Maaf role ini tidak bisa akses aplikasi'),
                ),
              );
            }
          }
          if (state.formSubmissionState is SubmissionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: const Key("error-login"),
                content: Text((state.formSubmissionState as SubmissionFailed)
                    .exception
                    .toString()),
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.bakery_dining,
                                    color: Colors.blue, size: 150),
                                Text(
                                  "ATMA KITCHEN",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          key: const Key("input-email"),
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Email',
                          ),
                          validator: (value) => value == ''
                              ? 'Masukan Email'
                              : EmailValidator.validate(value!)
                                  ? null
                                  : 'Email salah',
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          key: const Key("input-password"),
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                      IsPasswordVisibleChanged(),
                                    );
                              },
                              icon: Icon(
                                state.isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: state.isPasswordVisible
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                            ),
                          ),
                          obscureText: state.isPasswordVisible,
                          validator: (value) =>
                              value == '' ? 'Masukan Password' : null,
                        ),
                        SizedBox(height: 0.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ResetPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text('Lupa Password'),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      FormSubmitted(
                                          email: emailController.text,
                                          password: passwordController.text),
                                    );
                              }
                            },
                            child: Padding(
                              key: const ValueKey('login'),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: state.formSubmissionState is FormSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(fontSize: 3.h),
                                    ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Belum mempunyai Akun ? '),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Registerview(),
                                  ),
                                );
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> saveLoginData(User userData) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setInt('userID', userData.id!);
    await sharedPrefs.setInt('roleID', userData.id!);
    await sharedPrefs.setString('username', userData.name);
    await sharedPrefs.setString('token', userData.token!);
  }
}
