import 'package:biometrics_auth_poc/feature/biometrics/data/repository/local_auth_biometrics_repository.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/pin_code_auth_page.dart';
import 'package:flutter/material.dart';

class BiometricsPage extends StatefulWidget {
  const BiometricsPage({Key? key}) : super(key: key);

  @override
  State<BiometricsPage> createState() => _BiometricsPageState();
}

class _BiometricsPageState extends State<BiometricsPage> {
  final LocalAuthBiometricsRepository biometricsRepository =
      LocalAuthBiometricsRepository();

  List<String> _availableBiometrics = [];
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
                final hasBiometrics =
                    await biometricsRepository.hasBiometrics();
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
                final isAuthenticated =
                    await biometricsRepository.authenticateWithBiometrics();
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
                final biometrics =
                    await biometricsRepository.getAvailableBiometrics();
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
