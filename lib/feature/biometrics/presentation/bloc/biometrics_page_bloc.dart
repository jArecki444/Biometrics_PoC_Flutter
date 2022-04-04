import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/repository/biometrics_repository.dart';

part 'biometrics_page_event.dart';
part 'biometrics_page_state.dart';
part 'biometrics_page_bloc.freezed.dart';

class BiometricsPageBloc
    extends Bloc<BiometricsPageEvent, BiometricsPageState> {
  final BiometricsRepository _biometricsRepository;

  Future<void> initialize() async {
    final isBiometricsAvailable = await _biometricsRepository.hasBiometrics();
    final availableBiometricOptions =
        await _biometricsRepository.getAvailableBiometrics();
    add(
      BiometricsPageEvent.setBiometricsAvailability(
        isBiometricsAvailableOnDevice: isBiometricsAvailable,
        availableBiometricOptions: availableBiometricOptions,
      ),
    );
  }

  BiometricsPageBloc(this._biometricsRepository)
      : super(
          const BiometricsPageState(
            availableBiometricsOptions: [],
            pageStatus: PageStatus.checkingBiometricsAvailability(),
          ),
        ) {
    on<SetBiometricsAvailabilityEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            availableBiometricsOptions: event.availableBiometricOptions,
            pageStatus: event.isBiometricsAvailableOnDevice &&
                    event.availableBiometricOptions.isNotEmpty
                ? const PageStatus.waitingForSelectionOfAuthMethod()
                : PageStatus.biometricsUnavailable(
                    reason: event.availableBiometricOptions.isEmpty
                        ? UnavailableBiometricsReasonEnum
                            .biometricsNotConfigured
                        : UnavailableBiometricsReasonEnum
                            .biometricsNotAvailableOnDevice),
          ),
        );
      },
    );
    on<TryToAuthorizeWithBiometricsEvent>(
      (event, emit) async {
        final isAuthorized =
            await _biometricsRepository.authenticateWithBiometrics();
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
