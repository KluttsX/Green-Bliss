import 'dart:math';

import 'package:Bliss/screens/guide_details.dart';
import 'package:Bliss/screens/guide_page.dart';
import 'package:Bliss/screens/map.dart';
import 'package:Bliss/widgets/card.dart';
import 'package:Bliss/widgets/point.dart';
import 'package:Bliss/widgets/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Streets {
  final String id;
  final String calle;
  final String desc;
  final String image;
  final String ubicacion;

  Streets({
    required this.id,
    required this.calle,
    required this.desc,
    required this.image,
    required this.ubicacion,
  });
}

class _HomePageState extends State<HomePage> {
  List<int> selectedIndices = [];
  List<Streets> maker = [];

  int getRandomIndex() {
    if (selectedIndices.length == GuidePage.guideDataList.length) {
      selectedIndices.clear();
    }

    int randomIndex;
    do {
      randomIndex = Random().nextInt(GuidePage.guideDataList.length);
    } while (selectedIndices.contains(randomIndex));

    selectedIndices.add(randomIndex);

    return randomIndex;
  }

  Future<void> loadStreets() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('zone').get();

      List<DocumentSnapshot> documents = querySnapshot.docs;

      setState(() {
        maker = documents.map((doc) {
          return Streets(
            id: doc.id,
            calle: doc['calle'],
            desc: doc['descripcion'],
            image: doc['image'],
            ubicacion: doc['ubicacion'],
          );
        }).toList();
      });
    } catch (error) {
      print('Error al cargar datos desde Firestore: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    loadStreets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
            child: Column(
              children: [
                SearchWidget(
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const WidgetGoogleMap(),
                      ),
                    );
                  },
                  content: 'Buscar puntos de reciclaje',
                  foreground: Colors.white,
                  background: Colors.black,
                ),
                const SizedBox(height: 30),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: maker.length,
                  itemBuilder: (context, index) {
                    final element = maker[index];
                    return PointRecycling(
                      title: element.id,
                      street: element.calle,
                      onclick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const WidgetGoogleMap(),
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Guia de Reciclaje',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const GuidePage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Ver todo',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      int randomIndex = getRandomIndex();
                      return CardWidget(
                        title: GuidePage.guideDataList[randomIndex].title,
                        img: GuidePage.guideDataList[randomIndex].imageshow,
                        desc: GuidePage.guideDataList[randomIndex].description,
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GuideDetailsPage(
                                      title: GuidePage
                                          .guideDataList[randomIndex].title,
                                      image: GuidePage
                                          .guideDataList[randomIndex].imageshow,
                                      info: GuidePage.guideDataList[randomIndex]
                                          .description,
                                      color: GuidePage
                                          .guideDataList[randomIndex]
                                          .background,
                                      box: GuidePage.guideDataList[randomIndex]
                                          .titleshow),
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
        ],
      ),
    );
  }
}
