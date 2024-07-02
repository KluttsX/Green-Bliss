import 'package:Bliss/screens/bugs_page.dart';
import 'package:Bliss/screens/search_help.dart';
import 'package:Bliss/services/send_email.dart';
import 'package:Bliss/widgets/help_items.dart';
import 'package:Bliss/widgets/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
        title: const Text(
          'Ayuda',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            const Text(
              "Recursos Populares",
              style: TextStyle(
                color: Color(0xFF101010),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20.0),
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
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final section = documents[index];
                    final title = section['title'];
                    final info = section['info'];
                    final intruct = section['intruct'];
                    return HelpItems(
                      title: title,
                      icon: Iconsax.document,
                      onClick: () {
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
                    );
                  },
                );
              },
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                SearchWidget(
                  background:
                      const Color.fromRGBO(62, 89, 84, 1).withOpacity(0.2),
                  foreground: Colors.black,
                  content: 'Buscar en Ayuda',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SearchHelp(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Divider(),
                HelpItems(
                  title: 'Enviar comentarios',
                  icon: Iconsax.message,
                  onClick: () async {
                    await OpenGmailService().launchGmail();
                  },
                ),
                const Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
