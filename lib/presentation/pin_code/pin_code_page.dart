import 'package:biometrics_auth_poc/presentation/pin_code/widgets/number_button_widget.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/widgets/pin_dot_widget.dart';
import 'package:flutter/material.dart';

class PinCodeAuthorizationPage extends StatelessWidget {
  const PinCodeAuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set up your pin code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(4, (index) => PinDot(input: index.isEven))),
            ),
            const Spacer(),
            Flexible(
              child: Row(
                children: [
                  Expanded(child: NumberButton(num: "1", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(child: NumberButton(num: "2", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(child: NumberButton(num: "3", onPressed: () => {})),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Flexible(
              child: Row(
                children: [
                  Expanded(child: NumberButton(num: "4", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(child: NumberButton(num: "5", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(child: NumberButton(num: "6", onPressed: () {})),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Flexible(
              child: Row(
                children: [
                  Expanded(child: NumberButton(num: "7", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(child: NumberButton(num: "8", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(child: NumberButton(num: "9", onPressed: () => {})),
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
                  Expanded(child: NumberButton(num: "0", onPressed: () => {})),
                  const SizedBox(width: 64),
                  Expanded(
                      child: IconButton(
                    icon: const Icon(Icons.backspace),
                    onPressed: () {},
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
