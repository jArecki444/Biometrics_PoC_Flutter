part of 'biometrics_page_bloc.dart';

@freezed
class BiometricsPageState with _$BiometricsPageState {
  const factory BiometricsPageState({
    required PageStatus pageStatus,
    required List<String> availableBiometricsOptions,
  }) = _BiometricsPageState;
}

@freezed
class PageStatus with _$PageStatus {
  const factory PageStatus.waitingForSelectionOfAuthMethod() =
      _WaitingForSelectionOfAuthMethod;
  const factory PageStatus.checkingBiometricsAvailability() =
      _CheckingBiometricsAvailability;
  const factory PageStatus.authorized() = _Authorized;
  const factory PageStatus.unauthorized() = _Unauthorized;
  const factory PageStatus.biometricsUnavailable({
    required UnavailableBiometricsReasonEnum reason,
  }) = _BiometricsUnavailable;
}

