import 'package:equatable/equatable.dart';

// TODO CLASSES NAMES

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchPersons extends PersonSearchEvent {
  final String personQuery;

  const SearchPersons(this.personQuery);
}
