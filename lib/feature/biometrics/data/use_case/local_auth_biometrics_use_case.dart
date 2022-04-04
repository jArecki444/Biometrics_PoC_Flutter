import 'package:biometrics_auth_poc/feature/biometrics/domain/repository/biometrics_repository.dart';
import 'package:biometrics_auth_poc/feature/biometrics/domain/use_case/biometrics_use_case.dart';

class LocalAuthBiometricsUseCase extends BiometricsUseCase {
  final BiometricsRepository _biometricsRepository;

  LocalAuthBiometricsUseCase(this._biometricsRepository);

  @override
  Future<bool> authenticateWithBiometrics() async {
    return await _biometricsRepository.authenticateWithBiometrics();
  }

  @override
  Future<List<String>> getAvailableBiometrics() async {
    return await _biometricsRepository.getAvailableBiometrics();
  }

  @override
  Future<bool> hasBiometricsEnabled() async {
    final biometricsSupportedOnDevice =
        await _biometricsRepository.hasBiometrics();
    final availableBiometricsOptions =
        await _biometricsRepository.getAvailableBiometrics();
    return biometricsSupportedOnDevice && availableBiometricsOptions.isNotEmpty;
  }


  @override
  Future<UnavailableBiometricsReasonEnum>
      getUnavailableBiometricsReason() async {
    final biometricsSupportedOnDevice =
        await _biometricsRepository.hasBiometrics();
    final availableBiometricsOptions =
        await _biometricsRepository.getAvailableBiometrics();
    return biometricsSupportedOnDevice && availableBiometricsOptions.isEmpty
        ? UnavailableBiometricsReasonEnum.biometricsNotConfigured
        : UnavailableBiometricsReasonEnum.biometricsNotSupportedOnDevice;
  }
}
