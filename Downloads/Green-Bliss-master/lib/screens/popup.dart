import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupPage extends StatelessWidget {
  const PopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF6f95ff),
    ));
    return Scaffold(
      backgroundColor: const Color(0xFF6f95ff),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 55,
                minWidth: 55,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/planet.png',
                    height: 400,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 40),
            const Text(
              'Botellas con Magia',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 35),
            ),
            const SizedBox(height: 40),
            const Text(
              'Descubre la magia del reciclaje transformando tus botellas de plástico en coloridas lámparas DIY.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
