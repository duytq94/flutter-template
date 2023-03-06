import 'package:flutter/material.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/utilities/utils.dart';

import '../themes/app_colors.dart';
import '../user_details/pages/user_details_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appConfig = getIt.get<AppConfig>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Utils.isProd(appConfig.flavor) ? AppColors.themColorProd : AppColors.themColorDev,
        ),
      ),
      home: Banner(
        message: Utils.isProd(appConfig.flavor) ? "Prod" : "Dev",
        location: BannerLocation.topEnd,
        child: const UserDetailsPage(),
      ),
    );
  }
}
