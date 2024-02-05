import 'dart:convert';

import 'package:http/http.dart';

Future<Response> postMethod(
    String url, Map<String, dynamic> body, Map<String, String> header) async {
  try {
    var response =
        await post(Uri.parse(url), headers: header, body: jsonEncode(body));
    return response;
  } catch (e) {
    throw ("Something Went Wrong");
  }
}

Future<Response> getMethode(String url) async {
  try {
    var response = await get(Uri.parse(url));
    return response;
  } catch (e) {
    throw ("Something Went Wrong");
  }
}
