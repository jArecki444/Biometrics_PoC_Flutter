abstract class StoredPinCodeRepository {
  Future<String?> getAlreadyStoredPinCode();
  Future<void> savePinCode(String pinCode);
  Future<void> deletePinCode();
}