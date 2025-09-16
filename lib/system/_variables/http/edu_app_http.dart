


import 'package:edu_student/system/_variables/http/app_http.dart';
import 'package:edu_student/system/_variables/value/app_const.dart';
import 'package:http/http.dart';

class EduMobileAppHttp extends AppHttp {
  static String eduUrl(String url) {
    return AppConst.urlEDU + url;
  }

    static String eduQlUrl(String url) {
    return AppConst.urlQlEDU + url;
  }

  static Future<Response> getData(
    String url,
    dynamic data,
    String? token, {
    String? sort,
  }) {

    return AppHttp.getData(AppConst.api, '/api-edu/$url', data, token, sort: sort);
  }
}
