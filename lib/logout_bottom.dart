import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/login_page.dart';

class LogoutBottom extends StatefulWidget {
  const LogoutBottom({super.key});

  @override
  State<LogoutBottom> createState() => _LogoutBottomState();
}

class _LogoutBottomState extends State<LogoutBottom> {
  @override
  void logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return IconButton(onPressed: logout, icon: Icon(Icons.login_outlined));
  }
}
