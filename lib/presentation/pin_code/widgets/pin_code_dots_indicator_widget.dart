import 'package:biometrics_auth_poc/presentation/pin_code/bloc/pin_code_page_bloc.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/widgets/pin_dot_widget.dart';
import 'package:flutter/material.dart';

class PinCodeDotsIndicator extends StatelessWidget {
  final PinCodePageState currentStateData;
  const PinCodeDotsIndicator({required this.currentStateData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => PinDot(
          fillDotBackground: index <
              getPinCodeLength(
                currentStateData.pageStatus,
                currentStateData.pinCode,
                currentStateData.repeatedPinCode,
              ),
        ),
      ),
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
