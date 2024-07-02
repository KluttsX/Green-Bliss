import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BugsPage extends StatelessWidget {
  final String title;
  final String intruct;
  final String info;

  const BugsPage({
    super.key,
    required this.title,
    required this.intruct,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final replaced = intruct.replaceAll(RegExp('/st/'), '\n');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Ayuda'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        shadowColor: Colors.black,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                info,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              Text(
                replaced,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Otros recursos',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('help_section')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final section = documents[index];
                      final title = section['title'];
                      final info = section['info'];
                      final intruct = section['intruct'];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BugsPage(
                                title: title,
                                intruct: intruct,
                                info: info,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '● $title',
                          softWrap: true,
                          style: TextStyle(
                            color: const Color.fromRGBO(62, 89, 84, 1)
                                .withOpacity(1),
                            fontSize: 17,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
