import 'package:biometrics_auth_poc/core/persistence/secure_storage/secure_storage.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/repository/pin_code_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStoredPinCodeRepository extends PinCodeRepository {
  final _pinCodeKey = 'PIN_CODE';
  final SecureStorage secureStorage;

  SecureStoredPinCodeRepository(this.secureStorage);

  @override
  Future<String?> getAlreadyStoredPinCode() async =>
      secureStorage.read(_pinCodeKey);

  @override
  Future<void> savePinCode(String pinCode) async =>
      secureStorage.write(_pinCodeKey, pinCode);

  @override
  Future<void> deletePinCode() async => secureStorage.remove(_pinCodeKey);
}
