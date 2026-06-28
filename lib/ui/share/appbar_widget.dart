import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
    dynamic cart, // Keep for compatibility
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toUpperCase(), style: const TextStyle(letterSpacing: 2)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
