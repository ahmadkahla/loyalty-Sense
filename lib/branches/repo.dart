// import 'package:dio/dio.dart';
//
// import '../app_all/ApiClient.dart';
// import '../app_all/ApiResul.dart';
// import 'branch_model.dart';
//
// class BranchesRepo {
//   final ApiClient _apiClient;
//
//   BranchesRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();
//
//   Future<ApiResult<List<Branch>>> fetchBranches({
//     required int languageCode,
//   }) async {
//     try {
//       final response = await _apiClient.getRequest(
//         path: '/GetERPBranches',
//         queryParams: {'OperNo': 16, 'Lang': languageCode},
//       );
//
//       print('Branches API status: ${response.statusCode}');
//       print('Branches API response: ${response.data}');
//
//       if (!_apiClient.isOk(response)) {
//         return Failure(
//           Exception('Failed to load branches. Status: ${response.statusCode}'),
//         );
//       }
//
//       // final jsonResponse = _apiClient.decodeResponse(response);
//       // final branches = _apiClient.parseList(
//       //   jsonResponse,
//       //   (json) => Branch.fromJson(json),
//       // );
//       final jsonResponse = _apiClient.decodeResponse(response);
//
//       final branches = _apiClient.parseList(
//         jsonResponse,
//         (json) => Branch.fromJson(json),
//       );
//
//       print('================ BRANCH DEBUG ================');
//
//       for (final branch in branches) {
//         print('--------------------------------');
//         print('Branch: ${branch.displayName}');
//         print('Latitude: ${branch.latitude}');
//         print('Longitude: ${branch.longitude}');
//         print('Google Rate URL: ${branch.googleRateUrl}');
//         print('Phone 1: ${branch.phone1}');
//         print('Phone 2: ${branch.phone2}');
//         print('RAW DATA: ${branch.rawData}');
//       }
//
//       print('==============================================');
//
//       return Success(branches);
//
//       return Success(branches);
//     } on DioException catch (e) {
//       return Failure(
//         Exception(e.message ?? 'Network error while loading branches'),
//       );
//     } catch (e) {
//       return Failure(Exception(e.toString()));
//     }
//   }
// }

import 'package:dio/dio.dart';

import '../app_all/ApiClient.dart';
import '../app_all/ApiResul.dart';
import 'branch_model.dart';

class BranchesRepo {
  final ApiClient _apiClient;

  BranchesRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  Future<ApiResult<List<Branch>>> fetchBranches({
    required int languageCode,
  }) async {
    try {
      // ============================================================
      // 1) جلب البيانات الأساسية (الاسم، الهواتف، ActKey) — حسب اللغة
      // ============================================================
      final infoResponse = await _apiClient.getRequest(
        path: '/GetERPBranches',
        queryParams: {'OperNo': 16, 'Lang': languageCode},
      );

      print('Branches API status: ${infoResponse.statusCode}');
      print('Branches API response: ${infoResponse.data}');

      if (!_apiClient.isOk(infoResponse)) {
        return Failure(
          Exception(
            'Failed to load branches. Status: ${infoResponse.statusCode}',
          ),
        );
      }

      final infoJson = _apiClient.decodeResponse(infoResponse);

      final infoBranches = _apiClient.parseList(
        infoJson,
        (json) => Branch.fromJson(json),
      );

      // ============================================================
      // 2) جلب الأوقات من /GetERPBranchOpening
      // ============================================================
      final openingResponse = await _apiClient.getRequest(
        path: '/GetERPBranchOpening',
      );

      print('🕐 Opening API status: ${openingResponse.statusCode}');
      print('🕐 Opening API response: ${openingResponse.data}');

      List<Branch> openingBranches = [];

      if (_apiClient.isOk(openingResponse)) {
        final openingJson = _apiClient.decodeResponse(openingResponse);

        openingBranches = _apiClient.parseList(
          openingJson,
          (json) => Branch.fromJson(json),
        );
      } else {
        print('⚠️ /GetERPBranchOpening failed, continuing without times');
      }

      // ============================================================
      // 3) دمج البيانات:
      //    الأسماء/الهواتف/ActKey من infoBranches
      //    الأوقات من openingBranches
      // ============================================================
      List<Branch> branches;

      if (openingBranches.isEmpty) {
        // لا توجد أوقات — نستخدم بيانات GetERPBranches كما هي
        branches = infoBranches;
      } else {
        final timesById = {for (final b in openingBranches) b.id: b};

        branches = infoBranches.map((info) {
          final times = timesById[info.id];
          if (times == null) return info;

          return info.copyWith(
            openTime: times.openTime,
            closeTime: times.closeTime,
          );
        }).toList();
      }

      // ============================================================
      // Debug
      // ============================================================
      print('================ BRANCH DEBUG ================');

      for (final branch in branches) {
        print('--------------------------------');
        print('Branch: ${branch.displayName}');
        print('Latitude: ${branch.latitude}');
        print('Longitude: ${branch.longitude}');
        print('Google Rate URL: ${branch.googleRateUrl}');
        print('Phone 1: ${branch.phone1}');
        print('Phone 2: ${branch.phone2}');
        print('Open Time: ${branch.openTime}');
        print('Close Time: ${branch.closeTime}');
        print('Is 24h: ${branch.isOpen24}');
        print('RAW DATA: ${branch.rawData}');
      }

      print('==============================================');

      return Success(branches);
    } on DioException catch (e) {
      return Failure(
        Exception(e.message ?? 'Network error while loading branches'),
      );
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
