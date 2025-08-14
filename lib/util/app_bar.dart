import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const MyAppBar({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,

      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        color: Colors.black54,
        iconSize: 28,
        onPressed: () {
          Navigator.pop(context);
        },
      )
          : IconButton(
        icon: const Icon(Icons.menu),
        color: Colors.black54,
        iconSize: 30,
        onPressed: () {

        },
      ),
      title: Image.asset('assets/images/weather_logo.png', height: 105),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.account_circle_rounded),
          iconSize: 38,
          color: Colors.black54,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}