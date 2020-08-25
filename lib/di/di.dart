import 'package:equilibra_mobile/data/local/cache/local_cache.dart';
import 'package:equilibra_mobile/data/local/cache/local_cache_impl.dart';
import 'package:equilibra_mobile/data/remote/data/repository/data_repo.dart';
import 'package:equilibra_mobile/data/remote/data/repository/data_repo_impl.dart';
import 'package:equilibra_mobile/data/remote/data/service/data_service_impl.dart';
import 'package:equilibra_mobile/data/remote/room/repository/room_repo_impl.dart';
import 'package:equilibra_mobile/data/remote/room/service/room_service_impl.dart';
import 'package:equilibra_mobile/data/remote/user/repository/user_repo.dart';
import 'package:equilibra_mobile/data/remote/user/repository/user_repo_impl.dart';
import 'package:equilibra_mobile/data/remote/user/service/user_service.dart';
import 'package:equilibra_mobile/data/remote/user/service/user_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton(sharedPreferences);

  getIt.registerLazySingleton<LocalCache>(
      () => LocalCacheImpl(sharedPreferences: getIt()));

  getIt.registerLazySingleton<UserService>(() => UserServiceImpl());
  getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(localCache: getIt(), userService: getIt()));

  getIt.registerLazySingleton<DataService>(() => DataServiceImpl());
  getIt.registerLazySingleton<DataRepo>(
      () => DataRepoImpl(localCache: getIt(), dataService: getIt()));

  getIt.registerLazySingleton<RoomService>(() => RoomServiceImpl());
  getIt.registerLazySingleton<RoomRepo>(
      () => RoomRepoImpl(localCache: getIt(), roomService: getIt()));

  //navigation service for performing navigation without a context (from stacked package)
  getIt.registerLazySingleton(() => NavigationService());
}
