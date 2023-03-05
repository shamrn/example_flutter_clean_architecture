import 'package:example_clean_architecture/features/home/domain/entities/person_entity.dart';
import 'package:example_clean_architecture/features/home/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/material.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              person.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            PersonCacheImageWidget(
              width: 260,
              height: 260,
              imageUrl: person.image,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      color: person.status == 'Alive'
                          ? Colors.green
                          : Colors.redAccent,
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(person.status,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    )),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            ..._titleAndDescSection(title: 'Species:', desc: person.species),
            const SizedBox(
              height: 12,
            ),
            ..._titleAndDescSection(
                title: 'Last know location:', desc: person.location.name),
            const SizedBox(
              height: 12,
            ),
            ..._titleAndDescSection(title: 'Origin:', desc: person.origin.name),
            const SizedBox(
              height: 12,
            ),
            ..._titleAndDescSection(
                title: 'Was created:', desc: person.created.year.toString()),
          ],
        ),
      ),
    );
  }

  List<Widget> _titleAndDescSection(
      {required String title, required String desc}) {
    return [
      Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.grey[500]),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(desc, style: const TextStyle(fontSize: 18)),
    ];
  }
}
