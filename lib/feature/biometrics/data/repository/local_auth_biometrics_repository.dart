import 'package:biometrics_auth_poc/feature/biometrics/domain/repository/biometrics_repository.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthBiometricsRepository extends BiometricsRepository {
  final _auth = LocalAuthentication();

  @override
  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Use one of available authentication methods',
        useErrorDialogs: true,
        stickyAuth: false,
        biometricOnly: true,
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<List<String>> getAvailableBiometrics() async {
    try {
      final biometricTypes = await _auth.getAvailableBiometrics();
      return biometricTypes.map((type) => type.toString()).toList();
    } on PlatformException catch (e) {
      print(e);
      return [];
    }
  }
}
