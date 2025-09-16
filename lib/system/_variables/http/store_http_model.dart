import 'package:http/http.dart';

import '../value/app_const.dart';
import 'app_http.dart';

class StoreAppHttp extends AppHttp {
  static String data(String url) {
    return AppConst.urlData + url;
  }

  static Future<Response> getData(
    String url,
    dynamic data,
    String? token, {
    String? sort,
  }) {

    // ignore: prefer_interpolation_to_compose_strings
    return AppHttp.getData(AppConst.urlData, '/api/' + url, data, token,
        sort: sort);
  }
}
