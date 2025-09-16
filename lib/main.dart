import 'package:device_info_plus/device_info_plus.dart';
import 'package:edu_student/system/_variables/storage/global_params.dart';
import 'package:edu_student/system/base/config/config_lifecycle.dart';
import 'package:edu_student/system/base/config/config_maper.dart';
import 'package:edu_student/system/base/config/config_notifi.dart';
import 'package:edu_student/system/base/view/screen_loading/screen_load_view.dart';
import 'package:edu_student/view/home/home_view.dart';
import 'package:edu_student/view/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:edu_student/system/observice/app_observer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';


final FlutterLocalNotificationsPlugin notificationsPlugin =
    GlobalParams.getLocalNotificationsPlugin();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'thongbao.net.vn',
  'Thông báo', // title, // description
  importance: Importance.high,
);
RemoteMessage? remoteMessage;
InAppWebViewController? webViewMainController;
String? token;
String? socalName;

final localhostServer = InAppLocalhostServer(documentRoot: 'assets');
int notifiCount = 0;
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

// Tạo 1 instance database chuẩn
final FirebaseDatabase database = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: 'https://chat-bot-ai-9005c-default-rtdb.firebaseio.com/',
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  initializeApp(); // Chạy các tác vụ async sau khi UI đã khởi tạo
}

Future<void> initializeApp() async {
  await Permission.microphone.request();
  await Permission.camera.request();

  await FlutterDownloader.initialize(debug: true, ignoreSsl: false);
  Bloc.observer = AppObserver();

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  StartMap.mapModal();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);

    notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreenView(),
        '/home': (context) => HomeView(),
        '/login': (context) => LoginView(),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async => setState(() {
          // globalModal.broadcastEventBus.fire(MessageModal("APP:ON"));
        }),
      ),
    );
  }

  void setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      StartNotification.showRemoteMessage(message);
    });
  }
}
