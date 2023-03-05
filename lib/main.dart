import 'package:example_clean_architecture/common/app_colors.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/person_list_cubit/person_list_cubit.dart';
import 'package:example_clean_architecture/features/home/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:example_clean_architecture/features/home/presentation/pages/person_screen.dart';
import 'package:example_clean_architecture/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) => sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(
            create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: AppColors.mainBackground),
        home: const HomePage(),
      ),
    );
  }
}
