import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/repositories/follower_repository.dart';
import 'package:flutter_template/repositories/repo_repository.dart';
import 'package:flutter_template/repositories/user_details_repository.dart';
import 'package:flutter_template/services/base_client.dart';
import 'package:flutter_template/services/dio_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AppInjection {
  static void configureInjection(AppConfig appConfig) {
    _injectAppConfig(appConfig);
    _injectNetwork(appConfig);
  }

  static void _injectAppConfig(AppConfig appConfig) {
    getIt.registerSingleton<AppConfig>(appConfig);
  }

  static void _injectNetwork(AppConfig appConfig) {
    var baseUrl = "https://api.github.com/";
    // Assuming we have different url, set here
    switch (appConfig.flavor) {
      case AppFlavor.prod:
        baseUrl = "https://api.github.com/";
        break;
      case AppFlavor.dev:
        baseUrl = "https://api.github.com/";
        break;
    }
    BaseClient dio = DioApiClient(baseUrl);

    getIt.registerSingleton<BaseClient>(dio);

    getIt.registerSingleton<UserDetailsRepository>(UserDetailsRepositoryImpl(dio));
    getIt.registerSingleton<FollowerRepository>(FollowerRepositoryImpl(dio));
    getIt.registerSingleton<RepoRepository>(RepoRepositoryImpl(dio));
  }
}
