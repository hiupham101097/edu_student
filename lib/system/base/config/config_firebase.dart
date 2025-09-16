import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:edu_student/main.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/_variables/storage/storage_data.dart';
import 'package:edu_student/system/base/config/config_notifi.dart';
import 'package:edu_student/system/base/controller/message/exec_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class StartFirebase {
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    StartNotification.showRemoteMessage(message);
  }

  static Future<void> configFirebase() async {
    FirebaseMessaging.onBackgroundMessage(
      StartFirebase.firebaseMessagingBackgroundHandler,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      ExecMessage.getValues(message);
      StartNotification.showRemoteMessage(message);
      notifiCount = notifiCount + 1;

      //var context = GlobalParams.getContext();
      // BlocProvider.of<HomeBloc>(
      //   // ignore: use_build_context_synchronously
      //   context!,
      // ).add(HomeNotiReceived("V")); // Gửi event đến HomeBloc ✅
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      ExecMessage.exec(message);
    });
  }

  static Future<void> initFirebase() async {
    try {
      var firebaseOption = Platform.isIOS
          ? const FirebaseOptions(
              apiKey: "AIzaSyC6056zcZBMtgt7CpRQehjNV-mmvLOIflg",
              appId: "1:580137525608:android:39109322238f29695db6dd",
              messagingSenderId: "580137525608",
              projectId: "thongbao-net-vn-914c6",
              storageBucket: "thongbao-net-vn-914c6.appspot.com",
            )
          : const FirebaseOptions(
              apiKey: "AIzaSyC6056zcZBMtgt7CpRQehjNV-mmvLOIflg",
              appId: "1:580137525608:android:39109322238f29695db6dd",
              messagingSenderId: "580137525608",
              projectId: "thongbao-net-vn-914c6",
              storageBucket: "thongbao-net-vn-914c6.appspot.com",
            );

      await Firebase.initializeApp(options: firebaseOption);
      // ignore: empty_catches
    } catch (error) {}

    // ignore: unused_local_variable
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    // ignore: unused_local_variable
    AndroidDeviceInfo? androidInfo;
    // ignore: unused_local_variable
    IosDeviceInfo? iosDeviceInfo;

    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    } else {
      androidInfo = await deviceInfo.androidInfo;
    }

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          sound: true,
          badge: true,
          alert: true,
        );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    await FirebaseMessaging.instance.deleteToken(); // Xóa token cũ

    await FirebaseMessaging.instance
        .getToken()
        .then((String? token) async {
          // ignore: prefer_conditional_assignment
          if (GlobalParams.getFirebaseToken() == null) {
            GlobalParams.setFirebaseToken(token!);
            StorageData.setValue('firebaseToken', token);
          }

          // if (token != null) {
          //   var userId = "";
          //   var user = await StorageData.getValue('profile');
          //   if (user != null) {
          //     var profileData = user != null ? json.decode(user) : null;
          //     userId = profileData["staff_id"];
          //     await StaffBaseApi().patchFcmToken(userId, token);
          //   }
          // }
        })
        .catchError((e) {
          // ignore: avoid_print
          print('Error getting FCM token: $e');
        });
  }

  static Future<String?> getAccessToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  static Future<RemoteMessage?> getMessage() {
    return FirebaseMessaging.instance.getInitialMessage();
  }
}
