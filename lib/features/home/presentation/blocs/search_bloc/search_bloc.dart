import 'package:example_clean_architecture/core/errors/failure.dart';
import 'package:example_clean_architecture/features/home/domain/usecases/search_person.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/search_bloc/search_event.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>(_onSearchPersons);
  }

  void _onSearchPersons(
      SearchPersons event, Emitter<PersonSearchState> state) async {
    emit(PersonSearchLoading());
    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: event.personQuery));

    emit(failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
