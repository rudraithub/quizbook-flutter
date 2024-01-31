import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rudra_it_hub/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyB8Z-gVdAEE3_HHXbbYBAxdWluOYh0HZ5E", // paste your api key here
      appId:
          "1:1019940755554:android:8362a8d5cd186c6796193b", //paste your app id here
      messagingSenderId: "1019940755554", //paste your messagingSenderId here
      projectId: "quiz-book-f4711", //paste your project id here
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}
