import 'package:biometrics_auth_poc/feature/biometrics/domain/use_case/biometrics_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometrics_page_event.dart';
part 'biometrics_page_state.dart';
part 'biometrics_page_bloc.freezed.dart';

class BiometricsPageBloc
    extends Bloc<BiometricsPageEvent, BiometricsPageState> {
  final BiometricsUseCase _biometricsUseCase;

  BiometricsPageBloc(this._biometricsUseCase)
      : super(
          const BiometricsPageState(
            availableBiometricsOptions: [],
            pageStatus: PageStatus.checkingBiometricsAvailability(),
          ),
        ) {
    on<SetBiometricsAvailabilityEvent>(
      (event, emit) async {
        final hasBiometricsEnabled =
            await _biometricsUseCase.hasBiometricsEnabled();

        //Check if biometric auth is supported on device and ready to use
        if (hasBiometricsEnabled) {
          final availableBiometrics =
              await _biometricsUseCase.getAvailableBiometrics();
          emit(
            state.copyWith(
              pageStatus: const PageStatus.waitingForSelectionOfAuthMethod(),
              availableBiometricsOptions: availableBiometrics,
            ),
          );
        } else {
          final unavailableBiometricsReason =
              await _biometricsUseCase.getUnavailableBiometricsReason();
          emit(
            state.copyWith(
              pageStatus: PageStatus.biometricsUnavailable(
                  reason: unavailableBiometricsReason),
            ),
          );
        }
      },
    );

    on<TryToAuthorizeWithBiometricsEvent>(
      (event, emit) async {
        final isAuthorized =
            await _biometricsUseCase.authenticateWithBiometrics();
        emit(
          state.copyWith(
            pageStatus: isAuthorized
                ? const PageStatus.authorized()
                : const PageStatus.unauthorized(),
          ),
        );
      },
    );

    on<RestartAuthStateEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            pageStatus: const PageStatus.waitingForSelectionOfAuthMethod(),
          ),
        );
      },
    );
  }
}
