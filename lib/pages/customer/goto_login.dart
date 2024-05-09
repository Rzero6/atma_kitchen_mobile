import 'package:atma_kitchen_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GoToLoginPage extends StatelessWidget {
  const GoToLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login dulu!"),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(3.h),
                child: ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Loginview())),
                    child: const Text("Login")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
