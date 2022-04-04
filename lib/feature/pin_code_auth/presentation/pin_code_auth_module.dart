import 'package:biometrics_auth_poc/feature/pin_code_auth/data/repository/secure_stored_pin_code_repository.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/data/use_case/secure_stored_pin_code_use_case.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/repository/pin_code_repository.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/use_case/pin_code_use_case.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class PinCodeAuthModule {
  @injectable
  PinCodePageBloc get bloc;

  @LazySingleton(as: PinCodeRepository)
  SecureStoredPinCodeRepository get repository;

  @LazySingleton(as: PinCodeUseCase)
  SecureStoredPinCodeUseCase get useCase;
}