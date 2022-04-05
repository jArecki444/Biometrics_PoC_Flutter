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

  group('Tests related to emitting eraseLastPinInputPressed event', () {
    blocTest<PinCodePageBloc, PinCodePageState>(
      'Should return pinCode without last character, after emitting eraseLastPinInputPressed event',
      build: () => bloc,
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForFirstPinCode(),
        pinCode: '123',
        repeatedPinCode: '',
        isPinCodeAlreadyStored: false,
      ),
      act: (bloc) =>
          bloc.add(const PinCodePageEvent.eraseLastPinInputPressed()),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForFirstPinCode(),
          pinCode: '12',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: false,
        ),
      ],
    );
    blocTest<PinCodePageBloc, PinCodePageState>(
      'Should return repeatedPinCode without last character, after emitting eraseLastPinInputPressed event',
      build: () => bloc,
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForRepeatedPinCode(),
        pinCode: '1234',
        repeatedPinCode: '125',
        isPinCodeAlreadyStored: false,
      ),
      act: (bloc) =>
          bloc.add(const PinCodePageEvent.eraseLastPinInputPressed()),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForRepeatedPinCode(),
          pinCode: '1234',
          repeatedPinCode: '12',
          isPinCodeAlreadyStored: false,
        ),
      ],
    );
  });

  group('Tests related to emitting tryAgainButtonPressed event', () {
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return initial state after emitting tryAgainButtonPressed event
    when user entered pin code that is different from the stored one''',
      build: () => bloc,
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.pinCodeNotMatch(),
        pinCode: '',
        repeatedPinCode: '',
        isPinCodeAlreadyStored: true,
      ),
      act: (bloc) => bloc.add(const PinCodePageEvent.tryAgainButtonPressed()),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForFirstPinCode(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: true,
        ),
      ],
    );
  });

  group(
      'Tests related to emitting final state (pinCodeMatch / pinCodeNotMatch)',
      () {
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return pinCodeMatch() state after emitting 4th character of pin code
    when there is already a stored pin code and it matches the entered pin code''',
      build: () {
        when(mockStoredPinCodeUseCase.isPinCodeAlreadyStored()).thenAnswer(
          (_) async => true,
        );
        when(mockStoredPinCodeUseCase.isMatchingPinCode('1234')).thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForFirstPinCode(),
        pinCode: '123',
        repeatedPinCode: '',
        isPinCodeAlreadyStored: true,
      ),
      act: (bloc) => bloc
          .add(const PinCodePageEvent.pinButtonButtonPressed(pinInput: '4')),
      wait: const Duration(milliseconds: 300),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForFirstPinCode(),
          pinCode: '1234',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: true,
        ),
        PinCodePageState(
          pageStatus: PageStatus.pinCodeMatch(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: true,
        ),
      ],
    );
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return pinCodeNotMatch() state after emitting 4th character of pin code
    when there is already a stored pin code and it does not match the entered pin code''',
      build: () {
        when(mockStoredPinCodeUseCase.isPinCodeAlreadyStored()).thenAnswer(
          (_) async => true,
        );
        when(mockStoredPinCodeUseCase.isMatchingPinCode(any)).thenAnswer(
          (_) async => false,
        );
        return bloc;
      },
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForFirstPinCode(),
        pinCode: '123',
        repeatedPinCode: '',
        isPinCodeAlreadyStored: true,
      ),
      act: (bloc) => bloc
          .add(const PinCodePageEvent.pinButtonButtonPressed(pinInput: '4')),
      wait: const Duration(milliseconds: 300),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForFirstPinCode(),
          pinCode: '1234',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: true,
        ),
        PinCodePageState(
          pageStatus: PageStatus.pinCodeNotMatch(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: true,
        ),
      ],
    );
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return pinCodeMatch() state after emitting 4th character of repeatedPinCode
    when there is no stored pin code but repeatedPinCode matches the entered pin code''',
      build: () {
        return bloc;
      },
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForRepeatedPinCode(),
        pinCode: '1234',
        repeatedPinCode: '123',
        isPinCodeAlreadyStored: false,
      ),
      act: (bloc) => bloc
          .add(const PinCodePageEvent.pinButtonButtonPressed(pinInput: '4')),
      wait: const Duration(milliseconds: 300),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForRepeatedPinCode(),
          pinCode: '1234',
          repeatedPinCode: '1234',
          isPinCodeAlreadyStored: false,
        ),
        PinCodePageState(
          pageStatus: PageStatus.pinCodeMatch(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: false,
        ),
      ],
    );

    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should return pinCodeNotMatch() state after emitting 4th character of repeatedPinCode
    when there is no already stored pin code and repeatedPinCode is different from the entered one''',
      build: () {
        return bloc;
      },
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForRepeatedPinCode(),
        pinCode: '1234',
        repeatedPinCode: '123',
        isPinCodeAlreadyStored: false,
      ),
      act: (bloc) => bloc
          .add(const PinCodePageEvent.pinButtonButtonPressed(pinInput: '0')),
      wait: const Duration(milliseconds: 300),
      expect: () => const <PinCodePageState>[
        PinCodePageState(
          pageStatus: PageStatus.waitingForRepeatedPinCode(),
          pinCode: '1234',
          repeatedPinCode: '1230',
          isPinCodeAlreadyStored: false,
        ),
        PinCodePageState(
          pageStatus: PageStatus.pinCodeNotMatch(),
          pinCode: '',
          repeatedPinCode: '',
          isPinCodeAlreadyStored: false,
        ),
      ],
    );
  });

  group(
      'Tests related to calling storedPinCodeUseCase methods, depending on called bloc events',
      () {
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should call savePinCode use case method once, when there is no stored pin code
      but repeatedPinCode matches the entered pin code''',
      build: () {
        return bloc;
      },
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForRepeatedPinCode(),
        pinCode: '1234',
        repeatedPinCode: '123',
        isPinCodeAlreadyStored: false,
      ),
      act: (bloc) => bloc.add(
        const PinCodePageEvent.pinButtonButtonPressed(pinInput: '4'),
      ),
      wait: const Duration(milliseconds: 300),
      verify: (_) {
        verify(mockStoredPinCodeUseCase.savePinCode('1234')).called(1);
      },
    );
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should call isPinCodeAlreadyStored use case method once after bloc initialization method''',
      build: () {
        when(mockStoredPinCodeUseCase.isPinCodeAlreadyStored()).thenAnswer(
          (_) async => false,
        );
        return bloc;
      },
      act: (bloc) => bloc.initialize(),
      verify: (_) {
        verify(mockStoredPinCodeUseCase.isPinCodeAlreadyStored()).called(1);
      },
    );
    blocTest<PinCodePageBloc, PinCodePageState>(
      '''Should call isMatchingPinCode use case method once when there is stored pin code
      and user enters 4th character of pinCode''',
      build: () {
        when(mockStoredPinCodeUseCase.isMatchingPinCode('1234')).thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      seed: () => const PinCodePageState(
        pageStatus: PageStatus.waitingForFirstPinCode(),
        pinCode: '123',
        repeatedPinCode: '',
        isPinCodeAlreadyStored: true,
      ),
      act: (bloc) => bloc.add(
        const PinCodePageEvent.pinButtonButtonPressed(pinInput: '4'),
      ),
      wait: const Duration(milliseconds: 300),
      verify: (_) {
        verify(mockStoredPinCodeUseCase.isMatchingPinCode('1234')).called(1);
      },
    );
  });
}
