import 'package:dio/dio.dart';
import 'package:going_going_frontend/models/response/check_request_response.dart';

import '../../models/response/common/error_info_reponse.dart';
import '../../models/response/common/info_response.dart';
import 'dio_service.dart';

class PartyApi {
  static Future<dynamic> getIsRequested(int partyId) async {
    try {
      final response = await DioClient.dio.get('/party/check-is-requested/$partyId');

      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        return CheckRequestResponse(isRequested: res.data!['is_request'], type: res.data!['type']);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error', code: '500');
      } else if (e.response!.statusCode == 400 || e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(message: 'Failed to check the request', code: '500');
      }
    }
    return null;
  }

  static Future<dynamic> deleteRequest(int partyId) async {
    try {
      final response = await DioClient.dio.delete('/party/cancel/$partyId');

      if (response.statusCode != 200) {
        return InfoResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error', code: '500');
      } else if (e.response!.statusCode == 400 || e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(message: 'Failed to cancel the request', code: '500');
      }
    }
    return null;
  }

  static void patchPending() {}
}
