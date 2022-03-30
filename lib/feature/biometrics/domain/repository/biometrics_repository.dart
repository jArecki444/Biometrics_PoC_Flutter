abstract class BiometricsRepository {
  /// Returns true if device is capable of checking biometrics
  Future<bool> hasBiometrics();

  /// Authenticates the user with biometrics
  Future<bool> authenticateWithBiometrics();

  /// Returns a list of enrolled biometrics
  Future<List<String>> getAvailableBiometrics();
}
