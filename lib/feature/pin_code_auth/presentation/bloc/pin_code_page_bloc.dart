import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/use_case/pin_code_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_code_page_event.dart';
part 'pin_code_page_state.dart';
part 'pin_code_page_bloc.freezed.dart';

class PinCodePageBloc extends Bloc<PinCodePageEvent, PinCodePageState> {
  final PinCodeUseCase _pinCodeUseCase;

  /// This is the first thing that will be called when user enters pin code page
  /// and it will check if there is already stored pin code.
  Future<void> initialize() async {
    final isPinCodeAlreadyStored =
        await _pinCodeUseCase.isPinCodeAlreadyStored();
    add(
      PinCodePageEvent.checkIfPinCodeIsAlreadyStored(
          isAlreadyStored: isPinCodeAlreadyStored),
    );
  }

  PinCodePageBloc(this._pinCodeUseCase)
      : super(
          const PinCodePageState(
            pageStatus: PageStatus.waitingForPinCode(),
            pinCode: '',
            repeatedPinCode: '',
            isPinCodeAlreadyStored: false,
          ),
        ) {
    // After block init we will assume that there is already a pin code stored
    on<CheckIfPinCodeIsAlreadyStored>(
      (event, emit) {
        emit(
          state.copyWith(
            isPinCodeAlreadyStored: event.isAlreadyStored,
          ),
        );
      },
    );

    on<EraseLastPinInputPressedEvent>(
      (event, emit) {
        if (state.repeatedPinCode.isNotEmpty) {
          emit(
            state.copyWith(
              repeatedPinCode: state.repeatedPinCode
                  .substring(0, state.repeatedPinCode.length - 1),
            ),
          );
        } else if (state.pinCode.isNotEmpty) {
          emit(
            state.copyWith(
              pinCode: state.pinCode.substring(0, state.pinCode.length - 1),
            ),
          );
        }
      },
    );

    on<TryAgainButtonPressedEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            pageStatus: const PageStatus.waitingForPinCode(),
            pinCode: '',
            repeatedPinCode: '',
          ),
        );
      },
    );

    on<PinButtonButtonPressedEvent>(
      (event, emit) async {
        if (state.pageStatus == const PageStatus.waitingForPinCode()) {
          emit(
            state.copyWith(
              pinCode: state.pinCode + event.pinInput,
            ),
          );

          // If after emit the pin code length is 4, then we need to check if the
          // pin code is already stored, if it is, then we will compare codes
          // otherwise we will wait for the repeated pin code
          if (state.pinCode.length == 4) {
            await Future.delayed(const Duration(milliseconds: 300));
            // This delay is used to give user time to see the pin code of full length before
            // we will show next step (waiting for repeated pin code / pin code match / pin code not match)

            if (state.isPinCodeAlreadyStored) {
              final isMatchingPinCode = await _pinCodeUseCase.isMatchingPinCode(
                state.pinCode,
              );
              emit(
                state.copyWith(
                  pageStatus: isMatchingPinCode
                      ? const PageStatus.pinCodeMatch()
                      : const PageStatus.pinCodeNotMatch(),
                  pinCode: '',
                  repeatedPinCode: '',
                ),
              );
            } else {
              //When first PIN is entered, and there is no stored PIN, then ask user to repeat first PIN input
              emit(
                state.copyWith(
                  pageStatus: const PageStatus.waitingForRepeatedPinCode(),
                ),
              );
            }
          }
        } else {
          if (state.pageStatus ==
              const PageStatus.waitingForRepeatedPinCode()) {
            emit(
              state.copyWith(
                repeatedPinCode: state.repeatedPinCode + event.pinInput,
              ),
            );
            // If after emit the repeated pin code length is 4
            // We will compare the two pin codes, if they are equal, then we will store the pin code
            // If pin codes are not equal, then we will show the user appropriate message based on pinCodeNotMatch state
            if (state.repeatedPinCode.length == 4) {
              await Future.delayed(const Duration(milliseconds: 300));
              // This delay is used to give user time to see the pin code of full length before
              // we will show result (pin code match / pin code not match)
              if (state.repeatedPinCode == state.pinCode) {
                await _pinCodeUseCase.savePinCode(state.pinCode);
                emit(
                  state.copyWith(
                    pageStatus: const PageStatus.pinCodeMatch(),
                    pinCode: '',
                    repeatedPinCode: '',
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    pageStatus: const PageStatus.pinCodeNotMatch(),
                    pinCode: '',
                    repeatedPinCode: '',
                  ),
                );
              }
            }
          }
        }
      },
    );
  }
}
