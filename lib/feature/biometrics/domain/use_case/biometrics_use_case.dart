abstract class BiometricsUseCase {

  /// Returns true if biometrics is configured on the device and is available for use
  Future<bool> hasBiometricsEnabled();

  /// Determine why biometrics is not available
  Future<UnavailableBiometricsReason> getUnavailableBiometricsReason();

  /// Try to authenticate the user with biometrics
  Future<bool> authenticateWithBiometrics();

  /// Returns a list of available biometrics methods (fingerprint, face recognition)
  Future<List<String>> getAvailableBiometrics();
}

enum UnavailableBiometricsReason {
  biometricsNotConfigured,
  biometricsNotSupportedOnDevice,
}