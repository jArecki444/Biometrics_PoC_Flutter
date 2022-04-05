import 'package:biometrics_auth_poc/feature/biometrics/data/use_case/local_auth_biometrics_use_case.dart';
import 'package:biometrics_auth_poc/feature/biometrics/domain/use_case/biometrics_use_case.dart';
import 'package:biometrics_auth_poc/feature/biometrics/presentation/bloc/biometrics_page_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'biometrics_page_bloc_test.mocks.dart';

@GenerateMocks([LocalAuthBiometricsUseCase])
void main() {
  late BiometricsPageBloc bloc;
  late MockLocalAuthBiometricsUseCase mockLocalAuthBiometricsUseCase;

  setUp(() {
    mockLocalAuthBiometricsUseCase = MockLocalAuthBiometricsUseCase();
    bloc = BiometricsPageBloc(mockLocalAuthBiometricsUseCase);
  });

  group(
    '''Tests related to Biometrics page bloc initialization,
  the first called event of this bloc will be BiometricsPageEvent.setBiometricsAvailability()''',
    () {
      blocTest<BiometricsPageBloc, BiometricsPageState>(
        '''Should return PageStatus.biometricsUnavailable after emitting initialization event 
      (setBiometricsAvailability) when result of hasBiometricsEnabled is false and
      getUnavailableBiometricsReason returns UnavailableBiometricsReason.biometricsNotSupportedOnDevice''',
        build: () {
          when(mockLocalAuthBiometricsUseCase.hasBiometricsEnabled())
              .thenAnswer(
            (_) async => false,
          );
          when(mockLocalAuthBiometricsUseCase.getUnavailableBiometricsReason())
              .thenAnswer(
            (_) async =>
                UnavailableBiometricsReason.biometricsNotSupportedOnDevice,
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          const BiometricsPageEvent.setBiometricsAvailability(),
        ),
        expect: () => <BiometricsPageState>[
          const BiometricsPageState(
            pageStatus: PageStatus.biometricsUnavailable(
              reason:
                  UnavailableBiometricsReason.biometricsNotSupportedOnDevice,
            ),
            availableBiometricsOptions: [],
          ),
        ],
      );
      blocTest<BiometricsPageBloc, BiometricsPageState>(
        '''Should return PageStatus.biometricsUnavailable after emitting initialization event 
      (setBiometricsAvailability) when result of hasBiometricsEnabled is false and
      getUnavailableBiometricsReason returns UnavailableBiometricsReason.biometricsNotConfigured''',
        build: () {
          when(mockLocalAuthBiometricsUseCase.hasBiometricsEnabled())
              .thenAnswer(
            (_) async => false,
          );
          when(mockLocalAuthBiometricsUseCase.getUnavailableBiometricsReason())
              .thenAnswer(
            (_) async => UnavailableBiometricsReason.biometricsNotConfigured,
          );
          return bloc;
        },
        act: (bloc) => bloc.add(
          const BiometricsPageEvent.setBiometricsAvailability(),
        ),
        expect: () => <BiometricsPageState>[
          const BiometricsPageState(
            pageStatus: PageStatus.biometricsUnavailable(
              reason: UnavailableBiometricsReason.biometricsNotConfigured,
            ),
            availableBiometricsOptions: [],
          ),
        ],
      );

      blocTest<BiometricsPageBloc, BiometricsPageState>(
        '''Should return PageStatus.waitingForSelectionOfAuthMethod after emitting initialization event 
      (setBiometricsAvailability) when result of hasBiometricsEnabled is true and getAvailableBiometrics returns not empty list''',
        build: () {
          when(mockLocalAuthBiometricsUseCase.hasBiometricsEnabled())
              .thenAnswer(
            (_) async => true,
          );
          when(mockLocalAuthBiometricsUseCase.getAvailableBiometrics())
              .thenAnswer(
            (_) async => ['fingerprint'],
          );
          return bloc;
        },
        act: (bloc) =>
            bloc.add(const BiometricsPageEvent.setBiometricsAvailability()),
        expect: () => <BiometricsPageState>[
          const BiometricsPageState(
              pageStatus: PageStatus.waitingForSelectionOfAuthMethod(),
              availableBiometricsOptions: ['fingerprint']),
        ],
      );
    },
  );

  group('Tests related to emitting TryAuthorizeWithBiometrics event', () {
    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should return PageStatus.authorized(), when response from
      authenticateWithBiometrics() use case method is true''',
      build: () {
        when(mockLocalAuthBiometricsUseCase.authenticateWithBiometrics())
            .thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      seed: () => const BiometricsPageState(
        pageStatus: PageStatus.waitingForSelectionOfAuthMethod(),
        availableBiometricsOptions: ['FaceId'],
      ),
      act: (bloc) =>
          bloc.add(const BiometricsPageEvent.tryToAuthorizeWithBiometrics()),
      expect: () => const <BiometricsPageState>[
        BiometricsPageState(
          pageStatus: PageStatus.authorized(),
          availableBiometricsOptions: ['FaceId'],
        ),
      ],
    );
    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should return PageStatus.unauthorized(), when response from
      authenticateWithBiometrics() use case method is false''',
      build: () {
        when(mockLocalAuthBiometricsUseCase.authenticateWithBiometrics())
            .thenAnswer(
          (_) async => false,
        );
        return bloc;
      },
      seed: () => const BiometricsPageState(
        pageStatus: PageStatus.waitingForSelectionOfAuthMethod(),
        availableBiometricsOptions: ['FaceId'],
      ),
      act: (bloc) =>
          bloc.add(const BiometricsPageEvent.tryToAuthorizeWithBiometrics()),
      expect: () => const <BiometricsPageState>[
        BiometricsPageState(
          pageStatus: PageStatus.unauthorized(),
          availableBiometricsOptions: ['FaceId'],
        ),
      ],
    );
  });

  group('Tests related to emitting restartAuthState event', () {
    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should return PageStatus.waitingForSelectionOfAuthMethod(), 
      when pageStatus was set to unauthorized() and user emitted restartAuthState event''',
      build: () => bloc,
      seed: () => const BiometricsPageState(
        pageStatus: PageStatus.unauthorized(),
        availableBiometricsOptions: ['FaceId'],
      ),
      act: (bloc) => bloc.add(const BiometricsPageEvent.restartAuthState()),
      expect: () => const <BiometricsPageState>[
        BiometricsPageState(
          pageStatus: PageStatus.waitingForSelectionOfAuthMethod(),
          availableBiometricsOptions: ['FaceId'],
        ),
      ],
    );
    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should return PageStatus.waitingForSelectionOfAuthMethod(), 
      when pageStatus was set to authorized() and user emitted restartAuthState event
      (just for debug purposes, to give the user an option to test authorization again)''',
      build: () => bloc,
      seed: () => const BiometricsPageState(
        pageStatus: PageStatus.authorized(),
        availableBiometricsOptions: ['FaceId'],
      ),
      act: (bloc) => bloc.add(const BiometricsPageEvent.restartAuthState()),
      expect: () => const <BiometricsPageState>[
        BiometricsPageState(
          pageStatus: PageStatus.waitingForSelectionOfAuthMethod(),
          availableBiometricsOptions: ['FaceId'],
        ),
      ],
    );
  });

  group('''Tests related to calling LocalAuthBiometricsUseCase methods
   depending on called bloc events''', () {
    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should call hasBiometricsEnabled and getUnavailableBiometricsReason methods when
        result of hasBiometricsEnabled is false. These methods should be called after
        emitting setBiometricsAvailability event''',
      build: () {
        when(mockLocalAuthBiometricsUseCase.hasBiometricsEnabled()).thenAnswer(
          (_) async => false,
        );
        when(mockLocalAuthBiometricsUseCase.getUnavailableBiometricsReason())
            .thenAnswer(
          (_) async =>
              UnavailableBiometricsReason.biometricsNotSupportedOnDevice,
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const BiometricsPageEvent.setBiometricsAvailability(),
      ),
      verify: (_) {
        verify(
          mockLocalAuthBiometricsUseCase.hasBiometricsEnabled(),
        ).called(1);
        verify(
          mockLocalAuthBiometricsUseCase.getUnavailableBiometricsReason(),
        ).called(1);
      },
    );
    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should call hasBiometricsEnabled and getAvailableBiometrics method when
        result of hasBiometricsEnabled is true. These methods should be called after
        emitting setBiometricsAvailability event''',
      build: () {
        when(mockLocalAuthBiometricsUseCase.hasBiometricsEnabled()).thenAnswer(
          (_) async => true,
        );
        when(mockLocalAuthBiometricsUseCase.getAvailableBiometrics())
            .thenAnswer(
          (_) async => ['FaceId'],
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const BiometricsPageEvent.setBiometricsAvailability(),
      ),
      verify: (_) {
        verify(
          mockLocalAuthBiometricsUseCase.hasBiometricsEnabled(),
        ).called(1);
        verify(
          mockLocalAuthBiometricsUseCase.getAvailableBiometrics(),
        ).called(1);
      },
    );

    blocTest<BiometricsPageBloc, BiometricsPageState>(
      '''Should call authenticateWithBiometrics use case method when
      user emitted tryToAuthorizeWithBiometrics event''',
      build: () {
        when(mockLocalAuthBiometricsUseCase.authenticateWithBiometrics())
            .thenAnswer(
          (_) async => true,
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const BiometricsPageEvent.tryToAuthorizeWithBiometrics(),
      ),
      verify: (_) {
        verify(
          mockLocalAuthBiometricsUseCase.authenticateWithBiometrics(),
        ).called(1);
      },
    );
  });
}
