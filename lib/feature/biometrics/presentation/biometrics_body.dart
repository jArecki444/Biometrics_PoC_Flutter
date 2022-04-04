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
                          onPressed: () => context
                              .read<BiometricsPageBloc>()
                              .add(
                                const BiometricsPageEvent.restartAuthState(),
                              ),
                          child: Text('Reset auth state'),
                        ),
                      ],
                    ),
                  ),
              unauthorized: () => const Center(
                    child: Text('Unauthorized'),
                  ),
              biometricsUnavailable: (UnavailableBiometricsReasonEnum reason) {
                switch (reason) {
                  case UnavailableBiometricsReasonEnum
                      .biometricsNotAvailableOnDevice:
                    return const Center(
                      child: Text('Biometrics not available on device'),
                    );
                  case UnavailableBiometricsReasonEnum.biometricsNotConfigured:
                    return const Center(
                      child: Text('Biometrics not configured'),
                    );
                }
              }),
        );
      },
    );
  }
}
