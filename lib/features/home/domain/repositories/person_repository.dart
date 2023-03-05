import 'package:dartz/dartz.dart';
import 'package:example_clean_architecture/core/errors/failure.dart';
import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
