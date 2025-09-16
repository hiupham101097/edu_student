

import 'package:edu_student/system/_variables/storage/sso_storage_data.dart';

class UserDataComponent {
  UserDataComponent();

  Future<String?> getAppToken() {
    return SSOStorageData.getToken();
  }

  Future<void> setAppToken(String token) {
    return SSOStorageData.setToken(token);
  }

  Future<void> removeAppToken() {
    return SSOStorageData.removeToken();
  }

  Future<String> getEncrptedAuthToken() {
    return SSOStorageData.getEncrptedAuthToken();
  }

  Future<void> setEncrptedAuthToken(String encrptedAuthtoken) {
    return SSOStorageData.setEncrptedAuthToken(encrptedAuthtoken);
  }
}
