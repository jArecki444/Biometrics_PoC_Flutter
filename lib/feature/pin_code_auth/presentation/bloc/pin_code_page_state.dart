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
  /// This status is initial when user enters pin code page.
  const factory PageStatus.waitingForPinCode() = _WaitingForPinCode;

  /// This status is used when there is no stored pin code and user entered 4th character of pinCode
  /// then we ask user to repeat pin code before we save it.
  const factory PageStatus.waitingForRepeatedPinCode() =
      _WaitingForRepeatedPinCodePageStatus;

  /// This status is used when stored pin code is equal to entered pin code.
  /// It also will be used when there is no stored pin code and user entered repeated pin code
  /// that is equal to entered pin code.
  const factory PageStatus.pinCodeMatch() = _PinCodeMatchPageStatus;

  /// This status is used when stored pin code is NOT equal to entered pin code.
  /// It also will be used when there is no stored pin code and user entered repeated pin code
  /// that is NOT equal to entered pin code.
  const factory PageStatus.pinCodeNotMatch() = _PinCodeNotMatchPageStatus;
}
