import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PointRecycling extends StatelessWidget {
  final String title;
  final String street;
  final Function() onclick;
  const PointRecycling(
      {super.key,
      required this.title,
      required this.street,
      required this.onclick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Iconsax.location,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(street),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
