import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/student_register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD1jv0vniYav7zzOzNQfIhowG4zkandCxg",
            authDomain: "nmt-apd-assignment.firebaseapp.com",
            projectId: "nmt-apd-assignment",
            storageBucket: "nmt-apd-assignment.appspot.com",
            messagingSenderId: "317241679287",
            appId: "1:317241679287:web:6af49c8679bb62b5221c32",
            measurementId: "G-DL5P7VNQ67"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentRegisterPage(),
    );
  }
}
