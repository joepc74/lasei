import 'package:flutter/material.dart';
import 'package:lasei/authentication.dart';
import 'package:lasei/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  debugPrint('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.instance.subscribeToTopic('Novedades');
  await FirebaseMessaging.instance
      .getToken()
      .then((value) => auth.token = value!);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('---------------->Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Message also contained a notification: ${message.notification}');
    }

    //NotificationService.showNotification(message);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SanFrancisco',
      ),
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(40, 38, 56, 1),
        body: LoginScreen(),
      ),
    );
  }
}
