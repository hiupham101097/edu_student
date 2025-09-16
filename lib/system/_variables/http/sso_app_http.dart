import 'package:http/http.dart';
import 'package:edu_student/system/_variables/value/app_const.dart';

import 'app_http.dart';

class SSOAppHttp extends AppHttp {
  static Future<Response> getData(
    String url,
    dynamic data,
    String? token, {
    String? sort,
  }) {
    return AppHttp.getData(AppConst.api, '/$url', data, token, sort: sort);
  }
}
