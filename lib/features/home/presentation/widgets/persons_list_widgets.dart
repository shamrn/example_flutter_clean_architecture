import 'dart:async';

import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/person_list_cubit/person_list_cubit.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/person_list_cubit/person_list_state.dart';
import 'package:example_clean_architecture/features/home/presentation/widgets/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        //BlocProvider.of<PersonListCubit>(context).loadPerson();
        context.read<PersonListCubit>().loadPerson();
      }
    });
  }

  PersonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      bool isLoading = false;

      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoading) {
        persons = state.oldPersonList;
        isLoading = true;
      } else if (state is PersonLoaded) {
        persons = state.personsList;
      } else if (state is PersonError) {
        return Text(state.message,
            style: const TextStyle(color: Colors.white, fontSize: 25));
      }
      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < persons.length) {
            return PersonCard(person: persons[index]);
          } else {
            Timer(const Duration(milliseconds: 60), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: persons.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
