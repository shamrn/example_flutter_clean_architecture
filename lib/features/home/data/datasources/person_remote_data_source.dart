import 'dart:convert';

import 'package:example_clean_architecture/core/errors/exception.dart';
import 'package:example_clean_architecture/features/home/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPerson(int page);

  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPerson(int page) =>
      _getPerson('https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPerson(String query) =>
      _getPerson('https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPerson(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // TODO response.statusCode == HttpStatus.ok
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
