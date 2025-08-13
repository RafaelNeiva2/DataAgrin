import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
        color: Colors.black54,
        iconSize: 30,
      ),
      title: Image.asset('assets/images/weather_logo.png', height: 105),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.account_circle_rounded),
          iconSize: 38,
          color: Colors.black54,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
