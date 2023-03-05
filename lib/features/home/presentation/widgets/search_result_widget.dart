import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';
import 'package:example_clean_architecture/features/home/presentation/pages/person_detail_screen.dart';
import 'package:example_clean_architecture/features/home/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;

  const SearchResult({Key? key, required this.personResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonDetailPage(person: personResult)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  PersonCacheImageWidget(
                      imageUrl: personResult.image,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(personResult.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 26.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
