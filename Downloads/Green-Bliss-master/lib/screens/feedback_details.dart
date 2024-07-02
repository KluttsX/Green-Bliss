import 'package:Bliss/widgets/messages_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FeedBackDetails extends StatefulWidget {
  const FeedBackDetails({super.key});

  @override
  State<FeedBackDetails> createState() => _FeedBackDetailsState();
}

class _FeedBackDetailsState extends State<FeedBackDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Iconsax.arrow_left,
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(top: 10),
          child: const Text(
            'Calificación general',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '5.0',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Iconsax.star1, color: Colors.orange),
                        Icon(Iconsax.star1, color: Colors.orange),
                        Icon(Iconsax.star1, color: Colors.orange),
                        Icon(Iconsax.star1, color: Colors.orange),
                        Icon(Iconsax.star1, color: Colors.orange),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Basado en 20 reseñas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRatingRow('Excellent', 0.8, Colors.black),
                      buildRatingRow('Good', 0.6, Colors.black),
                      buildRatingRow('Average', 0.4, Colors.black),
                      buildRatingRow('Poor', 0.2, Colors.black),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Comentarios',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildItem(
                      title: 'Usuario050',
                      rating: 5,
                      date: '2 day ago',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting.',
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                padding: const EdgeInsets.all(20),
                color: const Color.fromRGBO(29, 37, 43, 1),
                onPressed: () {},
                highlightColor: const Color.fromRGBO(29, 37, 43, 1),
                splashColor: const Color.fromRGBO(29, 37, 43, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                minWidth: 300,
                height: 35,
                textColor: Colors.white,
                child: const Text('Escribir opinión'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
