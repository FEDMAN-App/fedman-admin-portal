import 'package:easy_localization/easy_localization.dart';
import 'package:fedman_admin_app/core/network/api_client.dart';
import 'package:fedman_admin_app/core/utils/managers/google_signin_manager.dart';
import 'package:fedman_admin_app/presentation/account/data/repositories/local/local_auth_repo.dart';
import 'package:flutter/material.dart';

import 'package:fedman_admin_app/presentation/app/fedman_admin.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

   await setupDependencyInjection();

  //----setting auth token----/
   final localAuthRepository = GetIt.I.get<LocalAuthRepository>();
  GetIt.I.get<ApiClient>().setAuthToken(localAuthRepository.getAccessToken());

  /// ------///
  runApp(EasyLocalization(    supportedLocales: const [Locale('en', 'US'), Locale('it', 'IT')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),child:  const FedmanAdminApp()));
}



