import 'package:biometrics_auth_poc/feature/pin_code_auth/data/repository/secure_stored_pin_code_repository.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/repository/stored_pin_code_repository.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class PinCodeAuthModule {
  @injectable
  PinCodePageBloc get bloc;

  @LazySingleton(as: StoredPinCodeRepository)
  SecureStoredPinCodeRepository get repository;
}