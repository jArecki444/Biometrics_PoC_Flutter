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
  /// This status will be used when there is at least one biometrics option available.
  /// It is a one of possible results after emitting setBiometricsAvailability event.
  const factory PageStatus.waitingForSelectionOfAuthMethod() =
      _WaitingForSelectionOfAuthMethod;

  /// This status is initial, when user enters biometrics page.
  /// During this status we will check if there is at least one biometrics option available.
  /// This status will be established after emitting setBiometricsAvailability event.
  const factory PageStatus.checkingBiometricsAvailability() =
      _CheckingBiometricsAvailability;

  /// This status will be set after successful biometrics authentication.
  const factory PageStatus.authorized() = _Authorized;

  /// This status will be set after unsuccessful biometrics authentication.
  const factory PageStatus.unauthorized() = _Unauthorized;

  /// This status will be set when biometrics is unavailable.
  /// It is a one of possible results after emitting setBiometricsAvailability event.
  /// We need to provide reason of unavailable biometrics, so we can show appropriate message to user.
  const factory PageStatus.biometricsUnavailable({
    required UnavailableBiometricsReason reason,
  }) = _BiometricsUnavailable;
}
