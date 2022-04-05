# biometrics_auth_poc

The purpose of this proof of concept is to build biometric and pin code authorization features.
This application uses clean code architecture and tests written with bloc_test and mockito packages.

Available features:
- biometric authorization (face / fingerprint recognition)
- detecting whether biometrics is available on the device
- detecting available biometrics options
- authorization with a pin code
- saving the pin code in secure_storage
- deletion of saved pin code

## Initial steps
1. Get all required dependencies 

```flutter pub get```

2. Use build_runner to generate all required files

```flutter pub run build_runner build --delete-conflicting-outputs```