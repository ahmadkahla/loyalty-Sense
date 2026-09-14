// import 'package:dio/dio.dart';
//
// import '../app_all/ApiResul.dart';
// import '../app_all/BaseRepo.dart';
// import 'branch_model.dart';
//
// class BranchesRepo extends BaseRepo {
//   Future<ApiResult<List<Branch>>> fetchBranches({
//     required int languageCode,
//   }) async {
//     try {
//       final response = await getRequest(
//         path: '/GetERPBranches',
//         queryParams: {'OperNo': 16, 'Lang': languageCode},
//       );
//
//       print('Branches API status: ${response.statusCode}');
//       print('Branches API response: ${response.data}');
//
//       if (!isOk(response)) {
//         return Failure(
//           Exception(
//             'Failed to load branches. '
//             'Status code: ${response.statusCode}',
//           ),
//         );
//       }
//
//       final jsonResponse = decodeResponse(response);
//
//       final branches = parseList(jsonResponse, (json) => Branch.fromJson(json));
//
//       return Success(branches);
//     } on DioException catch (e) {
//       print('Branches API DioException: ${e.message}');
//       print('Response: ${e.response?.data}');
//
//       return Failure(
//         Exception(e.message ?? 'Network error while loading branches'),
//       );
//     } catch (e) {
//       print('Branches API error: $e');
//
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
      final response = await _apiClient.getRequest(
        path: '/GetERPBranches',
        queryParams: {'OperNo': 16, 'Lang': languageCode},
      );

      print('Branches API status: ${response.statusCode}');
      print('Branches API response: ${response.data}');

      if (!_apiClient.isOk(response)) {
        return Failure(
          Exception('Failed to load branches. Status: ${response.statusCode}'),
        );
      }

      final jsonResponse = _apiClient.decodeResponse(response);
      final branches = _apiClient.parseList(
        jsonResponse,
        (json) => Branch.fromJson(json),
      );

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
