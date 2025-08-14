import 'package:farmweather/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Provider<AppDatabase>(
    create: (context) => AppDatabase(),
    dispose: (context, db) => db.close(),
    child: const MyApp(),
  ),);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Weather',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        scaffoldBackgroundColor: Colors.white,
      ),


      home: const SplashPage(),
    );
  }
}
