import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  bool qrCodeDetected = false;


  @override
  Widget build(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        qrCodeDetected = false;
      },
    );

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            MobileScanner(
              onDetect: (capture) {
                if (!qrCodeDetected) {
                  qrCodeDetected = true;

                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Qr Scan'),
                          content: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(barcode.rawValue as String));
                               qrCodeDetected = false;
                            },
                            child: Text(
                              barcode.rawValue ?? 'No data found in QR',
                              style: const TextStyle(
                                color: Colors
                                    .blue, // Cambia el color del enlace según tu preferencia
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          actions: [
                            okButton,
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
