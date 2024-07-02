import 'package:Bliss/screens/blog.dart';
import 'package:Bliss/screens/blog_details.dart';
import 'package:Bliss/widgets/area_search.dart';
import 'package:Bliss/widgets/post_cell_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class SearchResults extends StatefulWidget {
  final String searchQuery;

  const SearchResults({super.key, required this.searchQuery});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<Post> allPosts = [];

  @override
  void initState() {
    super.initState();
    loadPost();
  }

  Future<void> loadPost() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('blogs').get();

      List<Post> loadedPosts = querySnapshot.docs.map((doc) {
        DateTime date = doc['date'] is Timestamp
            ? (doc['date'] as Timestamp).toDate()
            : DateTime.parse(doc['date']);

        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        return Post(
          title: doc['title'],
          image: doc['image'],
          author: doc['author'],
          info: doc['info'],
          filter: doc['filter'],
          date: formattedDate,
        );
      }).toList();

      setState(() {
        allPosts = loadedPosts;
      });

      // Imprimir todos los posts cargados en la consola
      print('Todos los posts cargados:');
      allPosts.forEach((post) {
        print(post.title);
      });
    } catch (error) {
      print('Error al cargar los posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Post> searchResults = allPosts
        .where((post) =>
            post.title
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            post.filter
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).popUntil((route) => route.isFirst);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => const NavigationPage()));
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 3,
        title: const Text('Resultados'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const AreaSearch(
                  title: 'Blogs',
                  icon: Iconsax.bookmark,
                  color: Colors.brown,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final post = searchResults[index];
                      return PostCellWidget(
                        title: post.title,
                        image: post.image,
                        author: post.author,
                        date: post.date,
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailsPage(
                                title: post.title,
                                image: post.image,
                                info: post.info,
                                author: post.author,
                                fecha: post.date,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
