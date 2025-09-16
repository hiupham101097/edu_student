
import 'package:edu_student/system/_variables/http/app_http.dart';
import 'package:edu_student/system/_variables/value/app_const.dart';
import 'package:http/http.dart';

class HubAppHttp extends AppHttp {
  static String hubUrl(String url) {
    return AppConst.urlEDU + url;
  }
    static String hubQLUrl(String url) {
    return AppConst.urlQlEDU + url;
  }
  static Future<Response> getData(
    String url,
    dynamic data,
    String? token, {
    String? sort,
  }) {
    return AppHttp.getData(AppConst.api, '/api-hub/$url', data, token,
        sort: sort);
  }
}
