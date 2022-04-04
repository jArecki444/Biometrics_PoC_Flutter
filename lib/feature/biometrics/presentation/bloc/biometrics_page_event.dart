part of 'biometrics_page_bloc.dart';

@freezed
class BiometricsPageEvent with _$BiometricsPageEvent {
  const factory BiometricsPageEvent.setBiometricsAvailability({
    required bool isBiometricsAvailableOnDevice,
    required List<String> availableBiometricOptions,
  }) = SetBiometricsAvailabilityEvent;
  const factory BiometricsPageEvent.tryToAuthorizeWithBiometrics() =
      TryToAuthorizeWithBiometricsEvent;
  const factory BiometricsPageEvent.restartAuthState() = RestartAuthStateEvent;
}
