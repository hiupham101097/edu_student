import 'package:edu_student/system/base/model/data/data_device_token_modal.dart';
import 'package:edu_student/system/base/model/login/login_model.dart';
import 'package:edu_student/system/base/model/settings/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:edu_student/system/base/model/user/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/model/user/profile_model.dart';

GetIt globalGetIt = GetIt.instance;

class GlobalParams {
  static final GlobalParams _instance = GlobalParams._internal();

  factory GlobalParams() => _instance;

  GlobalParams._internal();

  static DataDeviceTokenModel? _deviceToken;
  static List<SettingJson> _listUrl = [];

  // Getter cho deviceToken
  static DataDeviceTokenModel get deviceToken {
    _deviceToken ??= DataDeviceTokenModel();
    return _deviceToken!;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Xóa hết dữ liệu trong SharedPreferences

    // Unregister tất cả các instance đã đăng ký trong GetIt
    globalGetIt.reset();
  }

  // Setter cho deviceToken
  static void setDeviceToken(DataDeviceTokenModel token) {
    _deviceToken = token;
  }

  // Getter & Setter cho listUrl (trước đây là settings)
  static List<SettingJson> get listUrl => _listUrl;
  static void setListUrl(List<SettingJson> newList) {
    _listUrl = newList;
  }

  static String? fireBaseToken;

  static FlutterLocalNotificationsPlugin getLocalNotificationsPlugin() {
    if (globalGetIt.isRegistered<FlutterLocalNotificationsPlugin>() == false) {
      globalGetIt.registerSingleton<FlutterLocalNotificationsPlugin>(
          FlutterLocalNotificationsPlugin(),
          signalsReady: true);
    }

    return globalGetIt<FlutterLocalNotificationsPlugin>();
  }

  static GlobalKey<NavigatorState> getGlobalKeyNavigatorState() {
    if (globalGetIt.isRegistered<GlobalKey<NavigatorState>>() == false) {
      globalGetIt.registerSingleton<GlobalKey<NavigatorState>>(
          GlobalKey<NavigatorState>(),
          signalsReady: true);
    }

    return globalGetIt<GlobalKey<NavigatorState>>();
  }

  static void setFirebaseToken(String token) {
    if (!globalGetIt.isRegistered<String>(instanceName: "FirebaseToken")) {
      globalGetIt.registerSingleton<String>(token,
          instanceName: "FirebaseToken");
    } else {
      globalGetIt.unregister<String>(instanceName: "FirebaseToken");
      globalGetIt.registerSingleton<String>(token,
          instanceName: "FirebaseToken");
    }
  }

  static String? getFirebaseToken() {
    return globalGetIt.isRegistered<String>(instanceName: "FirebaseToken")
        ? globalGetIt<String>(instanceName: "FirebaseToken")
        : null;
  }

  /// Lưu token vào SharedPreferences và GetIt
  static Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);

    if (!globalGetIt.isRegistered<String>(instanceName: "auth_token")) {
      globalGetIt.registerSingleton<String>(token, instanceName: "auth_token");
    } else {
      globalGetIt.unregister<String>(instanceName: "auth_token");
      globalGetIt.registerSingleton<String>(token, instanceName: "auth_token");
    }
  }

  /// Lấy token từ GetIt hoặc SharedPreferences
  static Future<String?> getAuthToken() async {
    if (globalGetIt.isRegistered<String>(instanceName: "auth_token")) {
      return globalGetIt<String>(instanceName: "auth_token");
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  /// Lưu encrypted token
  static Future<void> setEncryptedToken(String encryptedToken) async {
    if (!globalGetIt.isRegistered<String>(instanceName: "encrypted_token")) {
      globalGetIt.registerSingleton<String>(encryptedToken,
          instanceName: "encrypted_token");
    } else {
      globalGetIt.unregister<String>(instanceName: "encrypted_token");
      globalGetIt.registerSingleton<String>(encryptedToken,
          instanceName: "encrypted_token");
    }
  }

  /// Lấy encrypted token
  static String? getEncryptedToken() {
    return globalGetIt.isRegistered<String>(instanceName: "encrypted_token")
        ? globalGetIt<String>(instanceName: "encrypted_token")
        : null;
  }

  /// lưu thông tin User từ GetIt
  static void setUserLogin(LoginModel user) {
    if (!globalGetIt.isRegistered<LoginModel>()) {
      globalGetIt.registerSingleton<LoginModel>(user);
    } else {
      globalGetIt.unregister<LoginModel>();
      globalGetIt.registerSingleton<LoginModel>(user);
    }
  }

  /// Lấy thông tin User từ GetIt
  static LoginModel? getUserLogin() {
    return globalGetIt.isRegistered<LoginModel>()
        ? globalGetIt<LoginModel>()
        : null;
  }

  static void clearUserLogin() {
    if (globalGetIt.isRegistered<LoginModel>()) {
      globalGetIt.unregister<LoginModel>();
    }
  }

  /// lưu thông tin User từ GetIt
  static void setUserData(UserDataModal user) {
    if (!globalGetIt.isRegistered<UserDataModal>()) {
      globalGetIt.registerSingleton<UserDataModal>(user);
    } else {
      globalGetIt.unregister<UserDataModal>();
      globalGetIt.registerSingleton<UserDataModal>(user);
    }
  }

  /// Lấy thông tin User từ GetIt
  static UserDataModal? getUserData() {
    return globalGetIt.isRegistered<UserDataModal>()
        ? globalGetIt<UserDataModal>()
        : null;
  }

  /// Lưu giá trị openSetWebToken (true/false)
  static Future<void> setOpenSetWebToken(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("openSetWebToken", value);

    if (!globalGetIt.isRegistered<bool>(instanceName: "openSetWebToken")) {
      globalGetIt.registerSingleton<bool>(value,
          instanceName: "openSetWebToken");
    } else {
      globalGetIt.unregister<bool>(instanceName: "openSetWebToken");
      globalGetIt.registerSingleton<bool>(value,
          instanceName: "openSetWebToken");
    }
  }

  /// Lấy giá trị openSetWebToken
  static Future<bool> getOpenSetWebToken() async {
    if (globalGetIt.isRegistered<bool>(instanceName: "openSetWebToken")) {
      return globalGetIt<bool>(instanceName: "openSetWebToken");
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("openSetWebToken") ?? false;
  }

  static Future<void> setTimeLine(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("timeLine", value);

    if (!globalGetIt.isRegistered<int>(instanceName: "timeLine")) {
      globalGetIt.registerSingleton<int>(value, instanceName: "timeLine");
    } else {
      globalGetIt.unregister<int>(instanceName: "timeLine");
      globalGetIt.registerSingleton<int>(value, instanceName: "timeLine");
    }
  }



  /// Lấy timeLine
  static Future<int> getTimeLine() async {
    if (globalGetIt.isRegistered<int>(instanceName: "timeLine")) {
      return globalGetIt<int>(instanceName: "timeLine");
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("timeLine") ?? 0;
  }

  /// Lưu giá trị Permision (true/false)
  static Future<void> setPermision(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("permision", value);

    if (!globalGetIt.isRegistered<bool>(instanceName: "permision")) {
      globalGetIt.registerSingleton<bool>(value, instanceName: "permision");
    } else {
      globalGetIt.unregister<bool>(instanceName: "permision");
      globalGetIt.registerSingleton<bool>(value, instanceName: "permision");
    }
  }

  /// Lấy giá trị Permision
  static Future<bool> getPermision() async {
    if (globalGetIt.isRegistered<bool>(instanceName: "permision")) {
      return globalGetIt<bool>(instanceName: "permision");
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("permision") ?? false;
  }

  /// lưu thông tin Profile từ GetIt
  static void setUserProfile(ProfileModel user) {
    if (!globalGetIt.isRegistered<ProfileModel>()) {
      globalGetIt.registerSingleton<ProfileModel>(user);
    } else {
      globalGetIt.unregister<ProfileModel>();
      globalGetIt.registerSingleton<ProfileModel>(user);
    }
  }

  /// Lấy thông tin Profile từ GetIt
  static ProfileModel? getUserProfile() {
    return globalGetIt.isRegistered<ProfileModel>()
        ? globalGetIt<ProfileModel>()
        : null;
  }
}
