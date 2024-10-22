import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/login_page.dart';

class LogoutBottom extends StatefulWidget {
  const LogoutBottom({super.key});

  @override
  State<LogoutBottom> createState() => _LogoutBottomState();
}

class _LogoutBottomState extends State<LogoutBottom> {
  void logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: logout, icon: const Icon(Icons.login_outlined));
  }
}
