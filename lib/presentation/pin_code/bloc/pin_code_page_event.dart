part of 'pin_code_page_bloc.dart';

@freezed
class PinCodePageEvent with _$PinCodePageEvent {
  const factory PinCodePageEvent.eraseLastPinInputPressed() =
      EraseLastPinInputPressedEvent;
  const factory PinCodePageEvent.pinButtonButtonPressed({required String pinInput}) =
      PinButtonButtonPressedEvent;
}
