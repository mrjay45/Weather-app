import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    var uri = Uri.parse(url);
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        log(response.statusCode);
      }
    } catch (e) {
      print('Exception has occurred');
    }
  }
}
