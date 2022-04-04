import 'package:biometrics_auth_poc/core/dependency_injection.dart';
import 'package:biometrics_auth_poc/feature/biometrics/presentation/biometrics_body.dart';
import 'package:biometrics_auth_poc/feature/biometrics/presentation/bloc/biometrics_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricsPage extends StatelessWidget {
  const BiometricsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inject<BiometricsPageBloc>()
        ..add(
          const BiometricsPageEvent.setBiometricsAvailability(),
        ),
      child: const BiometricsBody(),
    );
  }
}
