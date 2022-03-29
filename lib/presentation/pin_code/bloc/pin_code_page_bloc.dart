import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_code_page_event.dart';
part 'pin_code_page_state.dart';
part 'pin_code_page_bloc.freezed.dart';

class PinCodePageBloc extends Bloc<PinCodePageEvent, PinCodePageState> {
  PinCodePageBloc()
      : super(
          const PinCodePageState(
            pageStatus: PageStatus.waitingForFirstPinCode(),
            pinCode: '',
            repeatedPinCode: '',
            alreadyStoredPinCode: null,
          ),
        ) {
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
            pageStatus: const PageStatus.waitingForFirstPinCode(),
            pinCode: '',
            repeatedPinCode: '',
          ),
        );
      },
    );

    on<PinButtonButtonPressedEvent>(
      (event, emit) async {
        if (state.pinCode.length < 4) {
          final int currentPinCodeLength = state.pinCode.length + 1;
          emit(
            state.copyWith(
              pinCode: state.pinCode + event.pinInput,
            ),
          );
          if (currentPinCodeLength == 4) {
            await Future.delayed(const Duration(milliseconds: 200));
            emit(
              state.copyWith(
                pageStatus: const PageStatus.waitingForRepeatedPinCode(),
              ),
            );
          }
        } else {
          //When first PIN is entered, check if it matches with the stored PIN
          if (state.alreadyStoredPinCode != null) {
            emit(
              state.copyWith(
                pageStatus: state.alreadyStoredPinCode == state.pinCode
                    ? const PageStatus.pinCodeMatch()
                    : const PageStatus.pinCodeNotMatch(),
                pinCode: '',
                repeatedPinCode: '',
              ),
            );
            //When first PIN is entered, and there is no stored PIN, then ask user to repeat first PIN input
          } else {
            if (state.repeatedPinCode.length < 4) {
              emit(
                state.copyWith(
                  pageStatus: const PageStatus.waitingForRepeatedPinCode(),
                  repeatedPinCode: state.repeatedPinCode + event.pinInput,
                ),
              );

              if (state.repeatedPinCode.length == 4) {
                await Future.delayed(const Duration(milliseconds: 200));
                emit(
                  state.copyWith(
                    pageStatus: state.repeatedPinCode == state.pinCode
                        ? const PageStatus.pinCodeMatch()
                        : const PageStatus.pinCodeNotMatch(),
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
