// import 'package:dio/dio.dart';
//
// import 'app_all/ApiClient.dart';
// import 'app_all/ApiResul.dart';
// import 'app_all/api_failure.dart';
// import 'slider/app_slide_model.dart';
//
// class HomeDataRepo {
//   final ApiClient _apiClient;
//
//   HomeDataRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();
//
//   // ============================================================
//   // 🎨 FETCH SLIDERS (نفس المنطق الأصلي)
//   // ============================================================
//   Future<ApiResult<List<AppSlide>>> fetchSliders() async {
//     try {
//       final response = await _apiClient.dio.get('/GetAPPBannerActive');
//
//       final data = response.data;
//
//       if (data is List) {
//         final slides =
//             data
//                 .whereType<Map>()
//                 .map((e) => AppSlide.fromJson(Map<String, dynamic>.from(e)))
//                 .where((s) => s.isActive)
//                 .toList()
//               ..sort((a, b) => a.order.compareTo(b.order));
//
//         return Success(slides);
//       }
//
//       return Failure(
//         APIFailure(
//           message: 'No banners found',
//           statusCode: response.statusCode,
//           rawData: data,
//         ),
//       );
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
// }

// import 'package:dio/dio.dart';
//
// import 'app_all/ApiClient.dart';
// import 'app_all/ApiResul.dart';
// import 'app_all/api_failure.dart';
// import 'slider/app_slide_model.dart';
//
// class HomeDataRepo {
//   final ApiClient _apiClient;
//
//   HomeDataRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();
//
//   // ============================================================
//   // 🎨 FETCH SLIDERS
//   // ============================================================
//   Future<ApiResult<List<AppSlide>>> fetchSliders() async {
//     try {
//       final response = await _apiClient.dio.get('/GetAPPBannerActive');
//
//       final data = response.data;
//
//       if (data is List) {
//         final slides =
//             data
//                 .whereType<Map>()
//                 .map((e) => AppSlide.fromJson(Map<String, dynamic>.from(e)))
//                 .where((s) => s.isActive)
//                 .toList()
//               ..sort((a, b) => a.id.compareTo(b.id)); // 👈 ID بدل order
//
//         return Success(slides);
//       }
//
//       return Failure(
//         APIFailure(
//           message: 'No banners found',
//           statusCode: response.statusCode,
//           rawData: data,
//         ),
//       );
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
// }

// import 'package:dio/dio.dart';
//
// import '../app_all/ApiClient.dart';
// import '../app_all/ApiResul.dart';
// import '../app_all/api_failure.dart';
// import '../slider/app_slide_model.dart';
//
// class HomeDataRepo {
//   final ApiClient _apiClient;
//
//   HomeDataRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();
//
//   // ============================================================
//   // 🎨 FETCH SLIDERS
//   // ============================================================
//   Future<ApiResult<List<AppSlide>>> fetchSliders() async {
//     try {
//       final response = await _apiClient.dio.get('/GetAPPBannerActive');
//
//       final data = response.data;
//
//       if (data is List) {
//         final slides =
//             data
//                 .whereType<Map>()
//                 .map((e) => AppSlide.fromJson(Map<String, dynamic>.from(e)))
//                 .where((s) => s.isActive)
//                 .toList()
//               ..sort((a, b) => a.id.compareTo(b.id)); // 👈 ID بدل order
//
//         return Success(slides);
//       }
//
//       return Failure(
//         APIFailure(
//           message: 'No banners found',
//           statusCode: response.statusCode,
//           rawData: data,
//         ),
//       );
//     } on DioException catch (e) {
//       return Failure(APIFailure.fromDio(e));
//     } catch (e) {
//       return Failure(APIFailure(message: e.toString()));
//     }
//   }
// }

import 'package:dio/dio.dart';

import '../app_all/ApiClient.dart';
import '../app_all/ApiResul.dart';
import '../app_all/api_failure.dart';
import '../slider/app_slide_model.dart';

class HomeDataRepo {
  final ApiClient _apiClient;

  HomeDataRepo({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  // ============================================================
  // 🎨 FETCH SLIDERS
  // ============================================================
  Future<ApiResult<List<AppSlide>>> fetchSliders() async {
    try {
      final response = await _apiClient.dio.get('/GetAPPBannerActive');

      final data = response.data;

      if (data is List) {
        final slides =
            data
                .whereType<Map>()
                .map((e) => AppSlide.fromJson(Map<String, dynamic>.from(e)))
                .where((s) => s.isActive == true) // 👈⭐ == true بدل isActive
                .toList()
              ..sort((a, b) => a.id.compareTo(b.id)); // ترتيب حسب Id

        return Success(slides);
      }

      return Failure(
        APIFailure(
          message: 'No banners found',
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
}
