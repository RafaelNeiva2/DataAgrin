import 'dart:async';
import 'package:farmweather/pages/tasks_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const TodoPage()),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "weather_logo",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/weather_logo.png', height: 200),
              SizedBox(height: 20),
              SizedBox(
                height: 20,
                width: 20,
                child : CircularProgressIndicator(
                  color: Colors.grey,
                  strokeWidth: 3.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
