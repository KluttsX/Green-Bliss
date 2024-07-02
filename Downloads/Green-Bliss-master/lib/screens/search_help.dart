import 'package:Bliss/screens/bugs_page.dart';
import 'package:Bliss/widgets/help_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchHelp extends StatefulWidget {
  const SearchHelp({super.key});

  @override
  State<SearchHelp> createState() => _SearchHelpState();
}

class _SearchHelpState extends State<SearchHelp> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _searchFocus.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: const Color.fromRGBO(62, 89, 84, 1).withOpacity(0.2),
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: TextField(
            controller: _searchController,
            focusNode: _searchFocus,
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Buscar en Ayuda',
              border: InputBorder.none,
              suffixIcon: _searchTerm.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchTerm = '';
                        });
                      },
                    )
                  : null,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('help_section')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || _searchTerm.isEmpty) {
                return const Center(
                  child: Text('Empieza a buscar'),
                );
              }
              final documents = snapshot.data!.docs.where((doc) => doc['title']
                  .toString()
                  .toLowerCase()
                  .contains(_searchTerm.toLowerCase()));
              if (documents.isEmpty) {
                return const Center(
                  child: Text('No se encontraron resultados'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final section = documents.elementAt(index);
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
        ),
      ),
    );
  }
}
