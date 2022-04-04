import 'package:biometrics_auth_poc/feature/pin_code_auth/data/use_case/secure_stored_pin_code_use_case.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/bloc/pin_code_page_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'pin_code_page_bloc_test.mocks.dart';

@GenerateMocks([SecureStoredPinCodeUseCase])
void main() {
  late PinCodePageBloc bloc;
  late MockSecureStoredPinCodeUseCase mockStoredPinCodeUseCase;

  setUp(() {
    mockStoredPinCodeUseCase = MockSecureStoredPinCodeUseCase();
    bloc = PinCodePageBloc(mockStoredPinCodeUseCase);
  });

  group('Tests related to bloc initialization', () {
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return PageStatus.waitingForFirstPinCode() and isPinCodeAlreadyStored == true
       if stored pin code was found after initialization''',
      build: () {
        when(mockStoredPinCodeUseCase.isPinCodeAlreadyStored()).thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      act: (bloc) => bloc.initialize(),
      expect: () => <PinCodePageState>[
        const PinCodePageState(
          pageStatus: PageStatus.waitingForFirstPinCode(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: true,
        ),
      ],
    );
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return PageStatus.waitingForFirstPinCode() and isPinCodeAlreadyStored == false
       if stored pin code was not found after initialization''',
      build: () {
        when(mockStoredPinCodeUseCase.isPinCodeAlreadyStored()).thenAnswer(
          (_) async => false,
        );
        return bloc;
      },
      act: (bloc) => bloc.initialize(),
      expect: () => <PinCodePageState>[
        const PinCodePageState(
          pageStatus: PageStatus.waitingForFirstPinCode(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: false,
        ),
      ],
    );
  });
}
