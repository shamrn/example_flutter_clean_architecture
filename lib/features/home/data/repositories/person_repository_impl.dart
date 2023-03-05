import 'package:dartz/dartz.dart';
import 'package:example_clean_architecture/core/errors/exception.dart';
import 'package:example_clean_architecture/core/errors/failure.dart';
import 'package:example_clean_architecture/core/platform/network_info.dart';
import 'package:example_clean_architecture/features/home/data/datasources/person_local_data_source.dart';
import 'package:example_clean_architecture/features/home/data/datasources/person_remote_data_source.dart';
import 'package:example_clean_architecture/features/home/data/models/person_model.dart';
import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';
import 'package:example_clean_architecture/features/home/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() => remoteDataSource.getAllPerson(page));
   }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() => remoteDataSource.searchPerson(query));
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
