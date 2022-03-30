import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies(Environment environment) {
  getIt.registerSingleton(environment);

  $initGetIt(getIt);
}

T inject<T extends Object>({String? name, dynamic first, dynamic second}) =>
    getIt.get<T>(instanceName: name, param1: first, param2: second);
