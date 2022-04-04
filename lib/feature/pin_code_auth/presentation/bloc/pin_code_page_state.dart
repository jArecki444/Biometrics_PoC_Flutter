part of 'pin_code_page_bloc.dart';

@freezed
class PinCodePageState with _$PinCodePageState {
  const factory PinCodePageState({
    required String pinCode,
    required String repeatedPinCode,
    required bool isPinCodeAlreadyStored,
    required PageStatus pageStatus,
  }) = _PinCodePageState;
}

@freezed
class PageStatus with _$PageStatus {
  const factory PageStatus.waitingForFirstPinCode() = _WaitingForFirstPinCode;
  const factory PageStatus.waitingForRepeatedPinCode() =
      _WaitingForRepeatedPinCodePageStatus;
  const factory PageStatus.pinCodeMatch() = _PinCodeMatchPageStatus;
  const factory PageStatus.pinCodeNotMatch() = _PinCodeNotMatchPageStatus;
}
