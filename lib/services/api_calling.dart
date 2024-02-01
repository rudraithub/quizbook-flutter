import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:rudra_it_hub/services/apiresponse.dart';

class ApiController {
  static const Duration timeOutDuration = Duration(seconds: 30);
  static Future<bool> checkInternetStatus() async {
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

  static Map<String, String> geHeader({String method = 'POST'}) {
    Map<String, String> header = <String, String>{};
    try {
      if (method != "GET") {
        header['Content-type'] = "application/json";
      }
    } catch (e) {}

    log(json.encode(header));
    return header;
  }

  static Future<ApiResponse> get(String url) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      if (await checkInternetStatus() == false) {
        apiResponse.status = -1;
        return apiResponse;
      }
      var client = http.Client();
      final response = await client
          .get(Uri.parse(url), headers: geHeader(method: 'GET'))
          .timeout(timeOutDuration);
      log(response.body);
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse;
      } else {
        apiResponse.status = response.statusCode;
        apiResponse.data = null;
        apiResponse.message = "Internal server error";
      }
    } catch (ex) {
      apiResponse.status = -1;
      apiResponse.message = ex.toString();
    }
    return apiResponse;
  }

  static Future<ApiResponse> post(String url, Map<String, dynamic> body) async {
    ApiResponse apiResponse = ApiResponse();
    print('object');
    try {
      print('inside try');
      if (await checkInternetStatus() == true) {
        apiResponse.status = -1;
        print('hi');
        return apiResponse;
      }

      // var headers = {
      //   'content-Type': 'application/json',
      // };

      var client = http.Client();
      print("api $url $body");
      final response = await client
          .post(
            Uri.parse(url),
            body: body,
          ) //headers: headers
          .timeout(timeOutDuration);
      log("response.body $response");
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse;
      } else {
        apiResponse.status = response.statusCode;
        apiResponse.data = null;
        apiResponse.message = "Internal server error";
      }
    } catch (ex) {
      apiResponse.status = -1;
      apiResponse.message = ex.toString();
    }
    print("apiResponseapiResponse $apiResponse");
    return apiResponse;
  }

  // alpesh sir
  static Future<http.Response> commonPostMethod(String url, String body) async {
    try {
      if (await checkInternetStatus() == false) {
        //pop
      }
      var headers = {
        'Content-Type': 'application/json',
      };
      var response =
          await http.post(Uri.parse(url), body: body, headers: headers);
      return response;
    } catch (ex) {
      throw Exception([ex]);
    }
  }

  static Future<http.Response> commonGetMethod(String url) async {
    try {
      if (await checkInternetStatus() == false) {
        //pop
      }
      var response = await http.get(Uri.parse(url));
      return response;
    } catch (ex) {
      throw Exception([ex]);
    }
  }

  static Future<ApiResponse> put(String url, String body) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      if (await checkInternetStatus() == false) {
        apiResponse.status = -1;
        return apiResponse;
      }
      var client = http.Client();
      final response = await client
          .put(Uri.parse(url), body: body, headers: geHeader())
          .timeout(timeOutDuration);
      log(response.body);
      if (response.statusCode == 200) {
        print("response is ${response.body}");
        apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse;
      } else {
        apiResponse.status = response.statusCode;
        apiResponse.data = null;
        apiResponse.message = "Internal server error";
      }
    } catch (ex) {
      apiResponse.status = -1;
      apiResponse.message = ex.toString();
    }
    return apiResponse;
  }

  static Future<ApiResponse> delete(String url, String body) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      if (await checkInternetStatus() == false) {
        apiResponse.status = -1;
        return apiResponse;
      }
      var client = http.Client();
      final response = await client
          .delete(Uri.parse(url), body: body, headers: geHeader())
          .timeout(timeOutDuration);
      log(response.body);
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.fromJson(json.decode(response.body));
        return apiResponse;
      } else {
        apiResponse.status = response.statusCode;
        apiResponse.data = null;
        apiResponse.message = "Internal server error";
      }
    } catch (ex) {}
    return apiResponse;
  }

  static Future<ApiResponse> postFormData(
      String url, String filepath, Map<String, String>? param,
      {String method = "POST"}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      if (await checkInternetStatus() == false) {
        apiResponse.status = -1;
        return apiResponse;
      }
      var request = http.MultipartRequest(method, Uri.parse(url));
      request.headers.addAll(geHeader());
      if (param != null) {
        request.fields.addAll(param);
      }
      //String? contentType = lookupMimeType(filepath, headerBytes: [0xFF, 0xD8]);
      if (filepath.isNotEmpty) {
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
            'image', File(filepath).readAsBytesSync(),
            filename: basename(filepath),
            //  contentType:MediaType(contentType!.substring(0,contentType.indexOf('/')),contentType.substring(contentType.lastIndexOf('/')+1)),
            contentType: MediaType("image", "jpeg"));

        request.files.add(multipartFile);
      }
      var res = await request.send();
      final response = await http.Response.fromStream(
          res); //   var responseData = await res.stream.toBytes();
      log(response.body);
      if (response.statusCode == 200) {
        apiResponse = ApiResponse.fromJson(json.decode(response.body));
      } else {
        apiResponse.status = response.statusCode;
        apiResponse.data = null;
        apiResponse.message = "Internal server error";
      }
    } catch (ex) {
      apiResponse.status = -1;
      apiResponse.message = ex.toString();
    }
    return apiResponse;
  }
}
