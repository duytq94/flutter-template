import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/di/app_injection.dart';
import 'package:flutter_template/simple_bloc_observer.dart';

import '../config/app_config.dart';
import 'my_app.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  AppConfig config = const AppConfig("FT App Prod", AppFlavor.prod);
  AppInjection.configureInjection(config);
  runApp(const MyApp());
}
