import 'package:biometrics_auth_poc/core/dependency_injection.dart';
import 'package:biometrics_auth_poc/core/persistence/secure_storage/secure_storage.dart';
import 'package:biometrics_auth_poc/feature/biometrics/presentation/biometrics_page.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

void initApplication({required Environment environment}) async {
  // Ensure to run native code before the app starts.
  WidgetsFlutterBinding.ensureInitialized();

  // Configure dependency injection.
  configureDependencies(environment);

  // Initialize Secure Storage.
  await inject<SecureStorage>().initialize();

  runApp(const MyApp());
}

void main() {
  initApplication(
    environment: const Environment('development'),
  ); //only 'development' is set just for PoC purposes
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
