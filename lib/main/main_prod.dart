import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/simple_bloc_observer.dart';

import 'app_config.dart';
import 'my_app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  AppConfig config = const AppConfig("FT App Prod", AppFlavor.prod);
  runApp(MyApp(appConfig: config));
}
