import 'package:flutter/material.dart';
import 'package:marketpet/commons/responsive.dart';
import 'package:marketpet/screen/logins/login_desktop.dart';
import 'package:marketpet/screen/logins/login_mobile.dart';
import 'package:marketpet/screen/logins/login_tablet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive.isDestkop(context)
          ? const LoginDesktop()
          : Responsive.isTablet(context)
              ? const LoginTablet()
              : const LoginMobile(),
      // body: LayoutBuilder(
      //   builder: (context, constraints) {
      //     if (constraints.maxWidth < 600) {
      //       return const LoginMobile();
      //     } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
      //       return const LoginTablet();
      //     } else {
      //       return const LoginDesktop();
      //     }
      //   },
      // ),
    );
  }
}
