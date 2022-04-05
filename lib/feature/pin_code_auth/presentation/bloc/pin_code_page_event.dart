part of 'pin_code_page_bloc.dart';

@freezed
class PinCodePageEvent with _$PinCodePageEvent {

  /// This event is used when a user makes a mistake in entering pin code.
  /// and wants to delete last digit of pin code.
  const factory PinCodePageEvent.eraseLastPinInputPressed() =
      EraseLastPinInputPressedEvent;

  /// This event is used when user presses single digit pin code button.
  const factory PinCodePageEvent.pinButtonButtonPressed({required String pinInput}) =
      PinButtonButtonPressedEvent;
  
  /// This event is used when user wants to try another attempt to authorize with pin code
  /// in case of authentication failure.
  const factory PinCodePageEvent.tryAgainButtonPressed() =
      TryAgainButtonPressedEvent;

  /// This event is used only for debug purposes. It will delete already stored pin code. 
  const factory PinCodePageEvent.deleteStoredPinCodeButtonPressed() =
      DeleteStoredPinCodeButtonPressed;

  /// This event is used after bloc initialization, to determine if pin code is already stored.
  const factory PinCodePageEvent.checkIfPinCodeIsAlreadyStored({required bool isAlreadyStored}) =
      CheckIfPinCodeIsAlreadyStored;
}
