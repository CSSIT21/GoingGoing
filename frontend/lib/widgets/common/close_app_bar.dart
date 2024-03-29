import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class CloseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onPressed;

  const CloseAppBar({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(68.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, top: 28, right: 24),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
        ),
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headline3,
        elevation: 0,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: const Icon(
              Icons.close,
              color: AppColors.blackGrey,
            ),
            padding: EdgeInsets.zero,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
