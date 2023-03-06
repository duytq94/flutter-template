import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/simple_bloc_observer.dart';

import 'my_app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  AppConfig config = const AppConfig("FT App Dev", AppFlavor.dev);
  configDependencies(config);
  runApp(const MyApp());
}
