import 'package:biometrics_auth_poc/api/local_auth_api.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/pin_code_auth_body.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/pin_code_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  List<BiometricType> _availableBiometrics = [];
  bool? _canCheckBiometrics;
  bool _authorized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometrics PoC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: _canCheckBiometrics ?? false,
              child: Text('Can check biometrics: $_canCheckBiometrics'),
            ),
            ElevatedButton(
              child: const Text('Check biometrics'),
              onPressed: () async {
                final hasBiometrics = await LocalAuthApi.hasBiometrics();
                setState(() {
                  _canCheckBiometrics = hasBiometrics;
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Authorized: $_authorized'),
            ElevatedButton(
              child: const Text('Authenticate'),
              onPressed: () async {
                final isAuthenticated = await LocalAuthApi.authenticate();
                setState(() {
                  _authorized = isAuthenticated;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Available biometrics: $_availableBiometrics'),
            ElevatedButton(
              child: const Text('Get available biometrics'),
              onPressed: () async {
                final biometrics = await LocalAuthApi.getAvailableBiometrics();
                setState(() {
                  _availableBiometrics = biometrics;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PinCodeAuthPage(),
                  ),
                );
              },
              child: const Text('Use PIN code'),
            )
          ],
        ),
      ),
    );
  }
}
