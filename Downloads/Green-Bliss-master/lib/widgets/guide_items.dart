import 'package:flutter/material.dart';

class GuideItem extends StatelessWidget {
  final Color background;
  final String title;
  final String image;
  final Function() onTap;
  const GuideItem(
      {super.key,
      required this.background,
      required this.title,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        width: 155,
        height: 183,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Image.asset(
                image,
                height: 70,
                width: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
