import 'package:biometrics_auth_poc/feature/biometrics/data/repository/local_auth_biometrics_repository.dart';
import 'package:biometrics_auth_poc/feature/biometrics/data/use_case/local_auth_biometrics_use_case.dart';
import 'package:biometrics_auth_poc/feature/biometrics/domain/repository/biometrics_repository.dart';
import 'package:biometrics_auth_poc/feature/biometrics/domain/use_case/biometrics_use_case.dart';
import 'package:biometrics_auth_poc/feature/biometrics/presentation/bloc/biometrics_page_bloc.dart';
import 'package:injectable/injectable.dart';

@module
abstract class BiometricsModule {
  @injectable
  BiometricsPageBloc get bloc;

  @LazySingleton(as: BiometricsRepository)
  LocalAuthBiometricsRepository get repository;

  @LazySingleton(as: BiometricsUseCase)
  LocalAuthBiometricsUseCase get useCase;
}