import 'package:biometrics_auth_poc/feature/biometrics/domain/use_case/biometrics_use_case.dart';
import 'package:biometrics_auth_poc/feature/biometrics/presentation/bloc/biometrics_page_bloc.dart';
import 'package:biometrics_auth_poc/feature/pin_code_auth/presentation/pin_code_auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricsBody extends StatelessWidget {
  const BiometricsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BiometricsPageBloc, BiometricsPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Biometrics PoC'),
          ),
          body: state.pageStatus.when(
            waitingForSelectionOfAuthMethod: () {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Select authentication method'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<BiometricsPageBloc>().add(
                            const BiometricsPageEvent
                                .tryToAuthorizeWithBiometrics(),
                          ),
                      child: const Text('Authorize with biometrics'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PinCodeAuthPage(),
                        ),
                      ),
                      child: const Text('Authorize with PIN code'),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Debug info - Available biometrics options: ${state.availableBiometricsOptions}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
            checkingBiometricsAvailability: () => const Center(
              child: CircularProgressIndicator(),
            ),
            authorized: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Successfully authorized'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<BiometricsPageBloc>().add(
                          const BiometricsPageEvent.restartAuthState(),
                        ),
                    child: const Text('Reset auth state'),
                  ),
                ],
              ),
            ),
            unauthorized: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Unauthorized'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<BiometricsPageBloc>().add(
                          const BiometricsPageEvent.restartAuthState(),
                        ),
                    child: const Text('Reset auth state'),
                  ),
                ],
              ),
            ),
            biometricsUnavailable: (UnavailableBiometricsReasonEnum reason) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getBiometricsUnavailabilityReasonText(reason),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PinCodeAuthPage(),
                          ),
                        ),
                        child: const Text('Try with PIN code'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

String getBiometricsUnavailabilityReasonText(
    UnavailableBiometricsReasonEnum reason) {
  switch (reason) {
    case UnavailableBiometricsReasonEnum.biometricsNotSupportedOnDevice:
      return 'Biometrics are not supported on this device, please try with PIN code';
    case UnavailableBiometricsReasonEnum.biometricsNotConfigured:
      return 'Biometrics are not configured. Please check your device settings. You can also try authorization with PIN code.';
  }
}
