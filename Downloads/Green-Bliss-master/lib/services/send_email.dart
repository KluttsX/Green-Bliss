import 'package:url_launcher/url_launcher.dart';

class OpenGmailService {
  launchGmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'green-bliss@gmail.com',
      query: 'subject=Comentario sobre la app',
    );
    final url = params.toString();
    final urlPath = Uri.parse(url);
    launchUrl(urlPath);
  }
}
