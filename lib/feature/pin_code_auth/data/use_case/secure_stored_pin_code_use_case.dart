import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/repository/pin_code_repository.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/domain/use_case/pin_code_use_case.dart';

class SecureStoredPinCodeUseCase extends PinCodeUseCase {
  final PinCodeRepository _pinCodeRepository;

  SecureStoredPinCodeUseCase(this._pinCodeRepository);

  @override
  Future<bool> isPinCodeAlreadyStored() async =>
      await _pinCodeRepository.getAlreadyStoredPinCode() != null;

  @override
  Future<void> savePinCode(String pinCode) async =>
      await _pinCodeRepository.savePinCode(pinCode);

  @override
  Future<void> deletePinCode() async =>
      await _pinCodeRepository.deletePinCode();

  @override
  Future<bool> isMatchingPinCode(String pinCode) async {
    final storedPinCode = await _pinCodeRepository.getAlreadyStoredPinCode();
    return storedPinCode != null && storedPinCode == pinCode;
  }
}
