import 'package:flutter/material.dart';

class HelpItems extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onClick;
  const HelpItems(
      {super.key,
      required this.title,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onClick,
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromRGBO(62, 89, 84, 1).withOpacity(0.2),
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 250,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
