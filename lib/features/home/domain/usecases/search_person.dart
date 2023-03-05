import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:example_clean_architecture/core/errors/failure.dart';
import 'package:example_clean_architecture/core/usecases/usecase.dart';
import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';
import 'package:example_clean_architecture/features/home/domain/repositories/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  const SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
