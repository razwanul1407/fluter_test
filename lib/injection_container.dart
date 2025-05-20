import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/user_list/data/datasources/user_local_data_source.dart';
import 'features/user_list/data/datasources/user_remote_data_source.dart';
import 'features/user_list/data/repositories/user_repository_impl.dart';
import 'features/user_list/domain/usecases/get_users.dart';
import 'features/user_list/domain/usecases/search_users.dart';
import 'features/user_list/presentation/bloc/user_bloc.dart';
import 'package:fluter_test/features/user_list/domain/repository/user_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - User List
  sl.registerFactory(() => UserBloc(getUsers: sl(), searchUsers: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => SearchUsers(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClient(Dio()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
}
