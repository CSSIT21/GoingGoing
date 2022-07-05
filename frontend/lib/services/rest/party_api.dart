import 'package:dio/dio.dart';

import 'dio_service.dart';
import '../../models/response/check_request_response.dart';
import '../../models/response/common/error_info_response.dart';
import '../../models/response/common/info_response.dart';

class PartyApi {
  static Future<dynamic> getIsRequested(int partyId) async {
    try {
      final response =
          await DioClient.dio.get('/party/$partyId/check-is-requested');

      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        return CheckRequestResponse(
            isRequested: res.data!['is_request'], type: res.data!['type']);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error');
      } else if (e.response!.statusCode == 400 ||
          e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(
          message: 'Failed to check the request',
          code: '${e.response!.statusCode}',
        );
      }
    }
    return null;
  }

  static Future<dynamic> postSendRequest(int partyId) async {
    try {
      final response = await DioClient.dio.post('/party/$partyId/request');

      if (response.statusCode == 200) {
        return InfoResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error');
      } else if (e.response!.statusCode == 400 ||
          e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(
          message: 'Failed to send a request',
          code: '${e.response!.statusCode}',
        );
      }
    }
    return null;
  }

  static Future<dynamic> patchAcceptRequest(int partyId, int psgId) async {
    try {
      final response =
          await DioClient.dio.patch('/party/$partyId/accept/$psgId');

      if (response.statusCode == 200) {
        return InfoResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error');
      } else if (e.response!.statusCode == 400 ||
          e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(
          message: 'Failed to accept the request',
          code: '${e.response!.statusCode}',
        );
      }
    }
    return null;
  }

  static Future<dynamic> patchConfirm(int partyId) async {
    try {
      final response = await DioClient.dio.patch('/party/$partyId/confirmed');

      if (response.statusCode == 200) {
        return InfoResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error');
      } else if (e.response!.statusCode == 400 ||
          e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(
          message: 'Failed to confirm the ride',
          code: '${e.response!.statusCode}',
        );
      }
    }
    return null;
  }

  static Future<dynamic> deleteCancelRequest(int partyId) async {
    try {
      final response = await DioClient.dio.delete('/party/$partyId/cancel');

      if (response.statusCode == 200) {
        return InfoResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response == null) {
        return ErrorInfoResponse(message: 'Network Error');
      } else if (e.response!.statusCode == 400 ||
          e.response!.statusCode == 401) {
        return ErrorInfoResponse.fromJson(e.response!.data);
      } else {
        return ErrorInfoResponse(
          message: 'Failed to cancel the request',
          code: '${e.response!.statusCode}',
        );
      }
    }
    return null;
  }
}
