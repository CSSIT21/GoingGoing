import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes/routes.dart';
import '../../constants/assets_path.dart';
import '../../services/provider/user_provider.dart';
import '../../services/rest/profile_api.dart';
import '../../services/rest/schedule_api.dart';

class TitleBox extends StatefulWidget {
  const TitleBox({Key? key}) : super(key: key);

  @override
  State<TitleBox> createState() => _TitleBoxState();
}

class _TitleBoxState extends State<TitleBox> {
  @override
  Widget build(BuildContext context) {
    final _imagePath =
        context.select((UserProvider user) => user.pathProfilePic);

    return SizedBox(
      height: 50,
      child: Row(
        children: [
          GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, Routes.profile);
                ScheduleApi.getAppointmentSchedules(context);
                ScheduleApi.getHistorySchedules(context);
                ProfileApi.getUserProfile(context);
              },
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(left: 32, right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                      placeholder: const AssetImage(AssetsConstants.profile),
                      image: _imagePath.isEmpty
                          ? const AssetImage(AssetsConstants.profile)
                          : FileImage(File(
                                  '/data/user/0/com.example.going_going_frontend/cache/$_imagePath'))
                              as ImageProvider<Object>),
                ),
              )),
          Text(
            "My Activity",
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
