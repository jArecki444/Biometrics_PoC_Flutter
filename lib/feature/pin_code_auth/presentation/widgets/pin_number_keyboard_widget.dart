import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/widgets/number_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              for (int i = 1; i < 4; i++) ...[
                Expanded(
                  child: NumberButton(
                    num: '$i',
                    onPressed: () => context.read<PinCodePageBloc>().add(
                          PinCodePageEvent.pinButtonButtonPressed(
                            pinInput: '$i',
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  width: i != 3 ? 64 : 0,
                ), //Do not apply extra width to the last button
              ],
            ],
          ),
        ),
        const SizedBox(height: 32),
        Flexible(
          child: Row(
            children: [
              for (int i = 4; i < 7; i++) ...[
                Expanded(
                  child: NumberButton(
                    num: '$i',
                    onPressed: () => context.read<PinCodePageBloc>().add(
                          PinCodePageEvent.pinButtonButtonPressed(
                            pinInput: '$i',
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  width: i != 6 //Do not apply extra width to the last button
                      ? 64
                      : 0,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 32),
        Flexible(
          child: Row(
            children: [
              for (int i = 7; i < 10; i++) ...[
                Expanded(
                  child: NumberButton(
                    num: '$i',
                    onPressed: () => context.read<PinCodePageBloc>().add(
                          PinCodePageEvent.pinButtonButtonPressed(
                            pinInput: '$i',
                          ),
                        ),
                  ),
                ),
                SizedBox(
                  width: i != 9 //Do not apply extra width to the last button
                      ? 64
                      : 0,
                ),
              ]
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
                ),
              ),
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
