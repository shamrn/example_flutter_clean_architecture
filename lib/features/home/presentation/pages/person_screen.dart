import 'package:example_clean_architecture/features/home/presentation/widgets/custom_search_delegate_widget.dart';
import 'package:example_clean_architecture/features/home/presentation/widgets/persons_list_widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search),
              color: Colors.white)
        ],
      ),
      body: PersonsList(),
    );
  }
}
