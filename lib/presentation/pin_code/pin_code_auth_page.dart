import 'package:biometrics_auth_poc/presentation/pin_code/bloc/pin_code_page_bloc.dart';
import 'package:biometrics_auth_poc/presentation/pin_code/pin_code_auth_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeAuthPage extends StatelessWidget {
  const PinCodeAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PinCodePageBloc(),
      child: const PinCodeAuthBody(),

    );
  }
}
