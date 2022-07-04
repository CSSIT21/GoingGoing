import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../constants/assets_path.dart';
import '../../models/response/common/info_response.dart';
import '../../services/provider/user_provider.dart';
import '../../services/rest/party_api.dart';
import '../../widgets/common/alert_dialog.dart';
import '../../widgets/common/button.dart';

class WaitingRequestScreen extends StatelessWidget {
  const WaitingRequestScreen({Key? key}) : super(key: key);

  Future<void> _onBackToHome(BuildContext context, int partyId) async {
    Navigator.popUntil(context, (route) => route.isFirst);

    await PartyApi.patchAcceptRequest(partyId, context.read<UserProvider>().id);
    showAlertDialog(
      context,
      "Your request has been accepted. Now you join the party!",
      title: "Hello!",
    );
  }

  Future<void> _onCancelRequest(BuildContext context, int partyId) async {
    final result = await PartyApi.deleteCancelRequest(partyId);
    if (result is InfoResponse) {
      showAlertDialog(
        context,
        result.message!,
        success: result.success,
        onOk: () => Navigator.pop(context),
      );
    } else {
      showAlertDialog(context, result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WaitingRequestScreenArguments;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 195,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(AssetsConstants.waiting),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Please wait for the driver to \naccept your request',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.3),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "We'll send you a notification!",
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 12),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 53),
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Button(
                  text: "Back to Home",
                  onPressed: () => _onBackToHome(context, args.partyId),
                ),
                const SizedBox(
                  height: 16,
                ),
                Button(
                  text: "Cancel Request",
                  onPressed: () => _onCancelRequest(context, args.partyId),
                  color: AppColors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WaitingRequestScreenArguments {
  final int partyId;

  WaitingRequestScreenArguments(this.partyId);
}
