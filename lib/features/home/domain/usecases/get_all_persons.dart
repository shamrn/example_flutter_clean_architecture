import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:example_clean_architecture/core/errors/failure.dart';
import 'package:example_clean_architecture/core/usecases/usecase.dart';
import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';
import 'package:example_clean_architecture/features/home/domain/repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;

  GetAllPersons(this.personRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
