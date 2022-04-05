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
}
