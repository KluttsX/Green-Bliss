import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsWebView extends StatefulWidget {
  final String title;
  const SettingsWebView({super.key, required this.title});

  @override
  State<SettingsWebView> createState() => _SettingsWebViewState();
}

class _SettingsWebViewState extends State<SettingsWebView> {
  late WebViewController controller;
  late String url;

  @override
  void initState() {
    super.initState();
    url = getUrlForTitle(widget.title);

    controller = WebViewController()
      ..loadRequest(Uri.parse(url));
  }

  String getUrlForTitle(String title) {
    // Lógica para asignar la URL según el título
    if (title == 'Política de privacidad') {
      return 'https://rufilio.github.io/Policy-and-Terms//';
    } else {
      return 'https://rufilio.github.io/Policy-and-Terms/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
