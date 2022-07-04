import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';

class ProfileOption extends StatefulWidget {
  final String navigatePath;
  final String optionText;
  final IconData preFixIcon;
  final Function fetchData;

  const ProfileOption({
    Key? key,
    required this.navigatePath,
    required this.optionText,
    required this.preFixIcon,
    required this.fetchData,
  }) : super(key: key);

  @override
  State<ProfileOption> createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
         await Navigator.pushNamed(context, widget.navigatePath);
         widget.fetchData();
        },
        child: Container(
          height: 72,
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(16),),
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
                    Icon(widget.preFixIcon),
                    const SizedBox(width: 16),
                    Text(widget.optionText,
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
                const Icon(Icons.navigate_next_rounded),
              ],
            ),
          ),
        ));
  }
}
