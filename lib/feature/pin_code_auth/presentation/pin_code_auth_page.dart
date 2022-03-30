import 'package:biometrics_auth_poc/core/dependency_injection.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/pin_code_auth_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeAuthPage extends StatelessWidget {
  const PinCodeAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inject<PinCodePageBloc>(),
      child: const PinCodeAuthBody(),
    );
  }
}
