///

abstract class SecureStorage {
  /// Initializes the [SecureStorage] on application startup.
  ///
  /// The main purpose of this method is to ensure all the
  /// required key stores will be created once the
  /// application starts.
  ///
  /// Lazy initialization might result in unwanted runtime
  /// delays.
  Future<void> initialize();

  /// Persists given [value] at [key].
  Future<void> write(String key, String value);

  /// Receives value persisted at [key].
  Future<String?> read(String key);

  /// Removes value at [key].
  Future<void> remove(String key);

  /// Clears all the data from the [SecureStorage].
  Future<void> clear();
}