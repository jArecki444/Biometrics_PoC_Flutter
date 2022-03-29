import 'package:biometrics_auth_poc/presentation/pin_code/bloc/pin_code_page_bloc.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/widgets/number_button_widget.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/widgets/pin_dot_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeAuthBody extends StatelessWidget {
  const PinCodeAuthBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinCodePageBloc, PinCodePageState>(
      listener: (context, state) {
        if (state.pinCode.length == 4) {
          //show snack bar
          print('Please repeat PIN code');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('PIN authorization'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.pageStatus.when(
                  waitingForFirstPinCode: () => const Text('Enter PIN code'),
                  waitingForRepeatedPinCode: () =>
                      const Text('Repeat PIN code'),
                  pinCodeMatch: () => const Text('Successfully authenticated'),
                  pinCodeNotMatch: () => const Text('Pin codes do not match'),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => PinDot(
                        fillDotBackground: index <
                            getPinCodeLength(
                              state.pageStatus,
                              state.pinCode,
                              state.repeatedPinCode,
                            ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const Flexible(
                  flex: 2,
                  child: const PinNumberKeyboard(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int getPinCodeLength(
    PageStatus pageStatus,
    String firstPinCode,
    String repeatedPinCode,
  ) {
    return pageStatus.maybeWhen(
        waitingForFirstPinCode: () => firstPinCode.length,
        waitingForRepeatedPinCode: () => repeatedPinCode.length,
        orElse: () => 0);
  }
}

class PinNumberKeyboard extends StatelessWidget {
  const PinNumberKeyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Row(
            children: [
              Expanded(
                child: NumberButton(
                  num: "1",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "1",
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: NumberButton(
                  num: "2",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "2",
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: NumberButton(
                  num: "3",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "3",
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Flexible(
          child: Row(
            children: [
              Expanded(
                child: NumberButton(
                  num: "4",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "4",
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: NumberButton(
                  num: "5",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "5",
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: NumberButton(
                  num: "6",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "6",
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Flexible(
          child: Row(
            children: [
              Expanded(
                child: NumberButton(
                  num: "7",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "7",
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: NumberButton(
                  num: "8",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "8",
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 64),
              Expanded(
                child: NumberButton(
                  num: "9",
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.pinButtonButtonPressed(
                          pinInput: "9",
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Flexible(
          child: Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              const SizedBox(width: 64),
              Expanded(
                  child: NumberButton(
                num: "0",
                onPressed: () => context.read<PinCodePageBloc>().add(
                      const PinCodePageEvent.pinButtonButtonPressed(
                        pinInput: "0",
                      ),
                    ),
              )),
              const SizedBox(width: 64),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: () => context.read<PinCodePageBloc>().add(
                        const PinCodePageEvent.eraseLastPinInputPressed(),
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
