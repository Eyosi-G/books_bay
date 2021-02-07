import 'dart:convert';

import 'package:http/http.dart';
import '../constants.dart';

class CheckoutDataProvider {
  Future generateLink(List<String> books, String token) async {
    try {
      final client = Client();
      final response = await client.post(
        Endpoints.generateCheckoutURL,
        headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: json.encode({"books": books}),
      );
      if (response.statusCode != 200) {
        throw Exception('response failed');
      }
      final link = json.decode(response.body);
      return link['link'];
    } catch (e) {
      return null;
    }
  }
}
