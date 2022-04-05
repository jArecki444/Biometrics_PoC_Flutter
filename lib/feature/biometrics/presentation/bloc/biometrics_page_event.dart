part of 'biometrics_page_bloc.dart';

@freezed
class BiometricsPageEvent with _$BiometricsPageEvent {

  ///This event is used after bloc initialization, to determine available biometrics options.
  const factory BiometricsPageEvent.setBiometricsAvailability() =
      SetBiometricsAvailabilityEvent;

  ///This event is used when user wants to authorize with biometrics.
  const factory BiometricsPageEvent.tryToAuthorizeWithBiometrics() =
      TryToAuthorizeWithBiometricsEvent;

  ///This event is used when user wants to restart authentication process.
  const factory BiometricsPageEvent.restartAuthState() = RestartAuthStateEvent;
}
