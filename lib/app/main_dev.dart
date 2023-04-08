import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/di/app_injection.dart';
import 'package:flutter_template/simple_bloc_observer.dart';

import 'my_app.dart';

void main() {
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  Bloc.observer = SimpleBlocObserver();
  AppConfig config = const AppConfig("FT App Dev", AppFlavor.dev);
  AppInjection.configureInjection(config);
  runApp(const MyApp());
}
