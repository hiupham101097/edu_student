import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AppHttp {
  static Future<Response> getData(
    String authority,
    String path,
    dynamic data,
    String? token, {
    String? sort,
    Map<String, dynamic>? queryParams,
  }) {
    if (authority.startsWith("https://")) {
      return http.post(
        Uri.https(authority.replaceAll("https://", ""), path, queryParams),
        body: json.encode(
          // ignore: prefer_if_null_operators
          data == null
              ? sort == null
                  ? {"skipCount": 0, "maxResultCount": 9999}
                  : {"skipCount": 0, "maxResultCount": 9999, "sorting": sort}
              : data,
        ),
        headers: _getHeader(token),
      );
    } else {
      return http.post(
        Uri.http(authority.replaceAll("http://", ""), path, queryParams),
        body: json.encode(
          // ignore: prefer_if_null_operators
          data == null
              ? sort == null
                  ? {"skipCount": 0, "maxResultCount": 9999}
                  : {"skipCount": 0, "maxResultCount": 9999, "sorting": sort}
              : data,
        ),
        headers: _getHeader(token),
      );
    }
  }

  static dynamic _getHeader(String? token) {
    if (token != null) {
      return {"Content-Type": "application/json", "Authorization": token};
    }
    return {"Content-Type": "application/json"};
  }
}
