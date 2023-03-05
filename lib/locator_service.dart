import 'package:example_clean_architecture/core/platform/network_info.dart';
import 'package:example_clean_architecture/features/home/data/datasources/person_local_data_source.dart';
import 'package:example_clean_architecture/features/home/data/datasources/person_remote_data_source.dart';
import 'package:example_clean_architecture/features/home/data/repositories/person_repository_impl.dart';
import 'package:example_clean_architecture/features/home/domain/repositories/person_repository.dart';
import 'package:example_clean_architecture/features/home/domain/usecases/get_all_persons.dart';
import 'package:example_clean_architecture/features/home/domain/usecases/search_person.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/person_list_cubit/person_list_cubit.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(
    () => PersonListCubit(getAllPersons: sl<GetAllPersons>()),
  );
  sl.registerFactory(
    () => PersonSearchBloc(searchPerson: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
