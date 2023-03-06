import 'package:flutter_template/services/dio_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configDependencies(AppConfig appConfig) {
  getIt.registerSingleton<AppConfig>(appConfig);
  getIt.registerFactory(() => DioApiClient());
}

class AppConfig {
  final String appName;
  final AppFlavor flavor;

  const AppConfig(this.appName, this.flavor);
}

enum AppFlavor {
  dev,
  prod,
}
