import 'package:flutter_template/main/app_config.dart';

class Utils {
  static isProd(AppFlavor appFlavor) {
    return appFlavor == AppFlavor.prod;
  }
}
