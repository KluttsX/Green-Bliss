import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RegionWidget extends StatelessWidget {
  final String title;
  final Function() onClick;
  const RegionWidget({
    super.key,
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onClick,
        child: Row(
          children: [
            Container(
              width: 70,
              height: 55,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(62, 89, 84, 1).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Iconsax.map,
                size: 25,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
