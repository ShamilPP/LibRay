import 'package:http/http.dart' as http;

class WebService {
  static Future<bool> checkConnection(String url) async {
    try {
      var response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
