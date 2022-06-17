import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';

import '../../config/themes/app_colors.dart';

class LogoutOption extends StatefulWidget {
  final GestureTapCallback? onTap;

  const LogoutOption({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  State<LogoutOption> createState() => _LogoutOptionState();
}

class _LogoutOptionState extends State<LogoutOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,

        // onTap: () {
        //   Navigator.popAndPushNamed(context, Routes.login);
        // },
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 16),
                    Text('Log Out',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.redAccent)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
