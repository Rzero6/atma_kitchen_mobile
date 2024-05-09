import 'package:atma_kitchen_mobile/api/auth_client.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meminta Reset Password'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                TextFormField(
                  key: const Key("input-email"),
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(Icons.email_rounded),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      String response = "";
                      try {
                        response = await requestResetPassword();
                      } catch (e) {
                        response = e.toString();
                      } finally {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Pesan"),
                              content: Text(response),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Kirim",
                              style: TextStyle(fontSize: 3.h),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> requestResetPassword() async {
    return await AuthClient().requestResetPassword(emailController.text);
  }
}
