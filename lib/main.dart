import 'package:biometrics_auth_poc/feature/biometrics/presentation/biometrics_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometrics PoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BiometricsPage(),
    );
  }
}
