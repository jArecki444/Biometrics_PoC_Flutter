import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/widgets/pin_number_keyboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

            //waitingForPinCode or waitingForRepeatedPinCode page status
            orElse: () => Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.pageStatus.maybeWhen(
                      waitingForPinCode: () => 'Enter PIN code',
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
