import 'package:fedman_admin_app/core/utils/logger_service.dart';
import 'package:fedman_admin_app/presentation/federations/data/repositories/federation_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../presentation/account/data/repositories/account_repo.dart';
import '../../presentation/account/data/repositories/local/local_auth_repo.dart';
import '../../presentation/country_and_its_cities/data/countries_repo.dart';
import '../network/api_client.dart';




Future<void> setupDependencyInjection() async {
  final GetIt getIt = GetIt.instance;

  // SharedPreferences instance
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  // Register ApiClient
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: 'https://api.fedman.io'),
  );


  // Register AccountRepo
  getIt.registerLazySingleton<AccountRepo>(
    () => AccountRepo(
      apiClient: getIt<ApiClient>(),
    ),
  );

  getIt.registerLazySingleton<FederationRepo>(
        () => FederationRepo(
      apiClient: getIt<ApiClient>(),
    ),
  );

  // Register CountryRepo
  getIt.registerLazySingleton<CountryRepo>(
    () => CountryRepo(),
  );

  // Register AccountRepo
  getIt.registerLazySingleton<LoggerService>(
    () => LoggerService(
    ),
  );


  getIt.registerLazySingleton(
        () => LocalAuthRepository(getIt.get()),
  );


}


