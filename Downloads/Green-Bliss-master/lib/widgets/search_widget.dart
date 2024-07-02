import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchWidget extends StatelessWidget {
  final Function() onClick;
  final String content;
  final Color background;
  final Color foreground;
  const SearchWidget(
      {super.key,
      required this.onClick,
      required this.content,
      required this.background,
      required this.foreground});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 50,
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              padding: const EdgeInsets.all(5),
              child: Icon(
                Iconsax.search_normal,
                color: foreground,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
