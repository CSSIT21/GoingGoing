import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';


class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BackAppBar({Key? key, required this.title, }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: AppBar(
        backgroundColor: Colors.white,
        title: Text(title),
        centerTitle: true,
        titleTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 20),
        elevation: 0,
        leading: IconButton(
        
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 31),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(
            Icons.navigate_before_rounded,
            size: 32,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.of(
                context)
                .pop();
          },
        ),) ,
    );
  }
}