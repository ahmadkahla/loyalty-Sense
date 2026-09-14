import 'package:dio/dio.dart';

import '../app_all/ApiClient.dart';
import '../app_all/ApiResul.dart';
import '../app_all/api_failure.dart';
import '../app_all/user_loyalty.dart';

class LoyaltyCardRepo {
  final ApiClient _apiClient;

  LoyaltyCardRepo({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  // ============================================================
  // 📥 GET LOYALTY CARD
  // ============================================================
  Future<ApiResult<UserLoyalty>> getLoyaltyCard({
    required String customerNo,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/GetLoyaltyCardsByCustomerNo',
        queryParameters: {'Loyalty_Customer_No': customerNo},
      );

      final data = response.data;

      // الـ API يرجّع List من البطاقات — نأخذ أول عنصر
      if (data is List && data.isNotEmpty && data.first is Map) {
        final json = Map<String, dynamic>.from(data.first);
        return Success(UserLoyalty.fromJson(json));
      }

      // إذا رجّع Map مباشرة
      if (data is Map<String, dynamic>) {
        return Success(UserLoyalty.fromJson(data));
      }

      return Failure(
        APIFailure(
          message: 'No loyalty card found',
          statusCode: response.statusCode,
          rawData: data,
        ),
      );
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }

  // ============================================================
  // 🎁 CLAIM DAILY REWARD
  // ============================================================
  Future<ApiResult<bool>> claimDailyReward({
    required String customerNo,
    String transType = '3',
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/PostDailyReward',
        data: {
          'BodyParam': {
            'Loyalty_Customer_No': customerNo,
            'Trans_Type': transType,
          },
        },
      );

      final data = response.data;

      // السيرفر يرجّع رقم (عدد النقاط أو 1/0)
      if (data is num) {
        return Success(data > 0);
      }

      // إذا رجّع bool
      if (data is bool) {
        return Success(data);
      }

      // إذا رجّع Map فيه success
      if (data is Map && data['success'] is bool) {
        return Success(data['success'] as bool);
      }

      return const Success(false);
    } on DioException catch (e) {
      return Failure(APIFailure.fromDio(e));
    } catch (e) {
      return Failure(APIFailure(message: e.toString()));
    }
  }
}
