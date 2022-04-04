abstract class PinCodeUseCase {
  Future<bool> isPinCodeAlreadyStored();
  Future<bool> isMatchingPinCode(String pinCode);
  Future<void> savePinCode(String pinCode);
  Future<void> deletePinCode();
}