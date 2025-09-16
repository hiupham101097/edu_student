import 'package:edu_student/system/_variables/storage/storage_data.dart';

class SSOStorageData extends StorageData {
  static Future<void> setToken(String token) {
    return StorageData.setValue("jwt", token);
  }

  static Future<String?> getToken() async {
    var token = await StorageData.getValue("jwt");

    if (token != null) {
      return SSOStorageData._formatToken(token);
    }

    return null;
  }

  static Future<String?> getAccessToken() async {
    return await StorageData.getValue("jwt");
  }

  static Future<void> removeToken() {
    return StorageData.deleteValue("jwt");
  }

  static Future<dynamic> getUser() {
    return StorageData.getValue("CurrentUser");
  }

  static Future<void> setUser(dynamic user) {
    return StorageData.setValue("CurrentUser", user);
  }

  static Future<void> removeUser() {
    return StorageData.deleteValue("CurrentUser");
  }

  static String _formatToken(String token) {
    // ignore: prefer_interpolation_to_compose_strings
    return "Bearer " + token;
  }

  static Future<void> setEncrptedAuthToken(String encrptedAuthtoken) {
    return StorageData.setValue("enc_auth_token", encrptedAuthtoken);
  }

  static Future<String> getEncrptedAuthToken() async {
    String encrptedAuthtoken = await StorageData.getValue("enc_auth_token");
    return encrptedAuthtoken;
  }

  static Future<void> removeEncrptedAuthToken() {
    return StorageData.deleteValue("enc_auth_token");
  }
}
