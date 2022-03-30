
import 'package:biometrics_auth_poc/core/persistence/secure_storage/secure_data_storage.dart';
import 'package:biometrics_auth_poc/core/persistence/secure_storage/secure_storage.dart';
import 'package:injectable/injectable.dart';

@module 
abstract class SecureModule {
  @LazySingleton(as: SecureStorage)
  SecureDataStorage get storage;
}