import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_theme.dart';
import '../../core/navigation/app_routes.dart';


class FedmanAdminApp extends StatefulWidget {
  const FedmanAdminApp({super.key});

  @override
  State<FedmanAdminApp> createState() => _FedmanAdminAppState();
}

class _FedmanAdminAppState extends State<FedmanAdminApp> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleText: () => true,
      enableScaleWH: () => true,
      child: MaterialApp.router(

        title: 'Fedman admin',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRoutes.router,
      ),
    );
  }
}