import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rudra_it_hub/widgets/commo_alert_dilog.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';

Future<bool> checkInternetStatus() async {
  try {
    final result = await InternetAddress.lookup('example.com')
        .timeout(const Duration(seconds: 10));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  } catch (e) {
    return false;
  }
  return false;
}

Future<Response> postMethod(String url, Map<String, dynamic> body,
    Map<String, String> header, BuildContext context) async {
  try {
    if (await checkInternetStatus() == false) {
      print("Check ");
      commonSnackBar(
          context: context,
          msg: 'check your internet connection and try again');
      throw ("Check Your Connection");
    } else {
      var response =
          await post(Uri.parse(url), headers: header, body: jsonEncode(body));
      return response;
    }
  } catch (e) {
    rethrow;
  }
}

Future<Response> getMethode(String url, BuildContext context) async {
  try {
    if (await checkInternetStatus() == false) {
      commonSnackBar(
          context: context,
          msg: 'check your internet connection and try again');
      print('object');
      const CommonAlertDialog(
        message: "Pleaseeee",
      );
      throw ("check");
    }
    var response = await get(Uri.parse(url));
    return response;
  } catch (e) {
    throw ("Something Went Wrong");
  }
}
