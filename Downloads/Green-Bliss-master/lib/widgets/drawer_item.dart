import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.name, required this.icon, required this.onPressed});

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: const Color.fromRGBO(62, 89, 84, 1).withOpacity(0.2),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left:10, right: 10),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(icon, size: 25, color: Colors.black,),
              const SizedBox(width: 35,),
              Text(name, style: const TextStyle(fontSize: 18, color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}