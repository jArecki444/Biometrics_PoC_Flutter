
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/number_button_widget.dart';
import 'widgets/pin_code_dots_indicator_widget.dart';

class PinCodeAuthBody extends StatelessWidget {
  const PinCodeAuthBody({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PinCodePageBloc, PinCodePageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('PIN authorization'),
          ),
          body: state.pageStatus.maybeWhen(
            pinCodeMatch: () => const Center(
              child: Text('Authorization successful'),
            ),
            pinCodeNotMatch: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Authorization failed'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<PinCodePageBloc>().add(
                          const PinCodePageEvent.tryAgainButtonPressed(),
                        ),
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
            orElse: () => Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.pageStatus.maybeWhen(
                      waitingForFirstPinCode: () => 'Enter PIN code',
                      waitingForRepeatedPinCode: () => 'Repeat PIN code',
                      orElse: () => '',
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: PinCodeDotsIndicator(
                      currentStateData: state,
                    ),
                  ),
                  const Spacer(),
                  const Flexible(
                    flex: 2,
                    child: PinNumberKeyboard(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
