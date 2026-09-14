// import '../app_all/BaseRepo.dart';
// import 'notification_model.dart';
//
// class NotificationsRepo extends BaseRepo {
//   // ⚠️ مؤقتاً: CustomerId ثابت للاختبار
//   // لاحقاً: اقرأه من SharedPreferences بعد تسجيل الدخول
//   static const int customerId = 1;
//
//   /// جلب الإشعارات
//   Future<List<AppNotification>> fetchNotifications({
//     required int page,
//     bool? read,
//     int pageSize = 20,
//   }) async {
//     final response = await getRequest(
//       path: '/GetERPNotificationLogSearch',
//       queryParams: {
//         'CustomerId': customerId,
//         'IsRead': read ?? false,
//         'PageIndex': page,
//         'PageSize': pageSize,
//       },
//     );
//
//     if (!isOk(response)) {
//       throw Exception('Failed to fetch notifications');
//     }
//
//     final data = decodeResponse(response);
//     if (data == null) return [];
//
//     return parseList<AppNotification>(data, (e) => AppNotification.fromJson(e));
//   }
//
//   /// تعليم إشعار كمقروء
//   Future<bool> readNotification(final String id) async {
//     final response = await putRequest(
//       path: '/PutERPNotificationLog',
//       body: {
//         'BodyParam': {'CustomerId': customerId, 'NotificationId': id},
//       },
//     );
//
//     if (!isOk(response)) {
//       return false;
//     }
//
//     final jsonResponse = decodeResponse(response);
//     if (jsonResponse is num) return jsonResponse >= 1;
//     return false;
//   }
// }

// import '../app_all/BaseRepo.dart';
// import 'notification_model.dart';
//
// class NotificationsRepo extends BaseRepo {
//   // ⚠️ مؤقتاً: CustomerId ثابت للاختبار
//   // لاحقاً: اقرأه من SharedPreferences بعد تسجيل الدخول
//   static const int customerId = 1;
//
//   /// جلب الإشعارات
//   Future<List<AppNotification>> fetchNotifications({
//     required int page,
//     bool? read,
//     int pageSize = 20,
//   }) async {
//     final response = await getRequest(
//       path: '/GetERPNotificationLogSearch',
//       queryParams: {
//         'CustomerId': customerId,
//         'IsRead': read ?? false,
//         'PageIndex': page,
//         'PageSize': pageSize,
//       },
//     );
//
//     if (!isOk(response)) {
//       throw Exception('Failed to fetch notifications');
//     }
//
//     final data = decodeResponse(response);
//     if (data == null) return [];
//
//     return parseList<AppNotification>(data, (e) => AppNotification.fromJson(e));
//   }
//
//   /// تعليم إشعار كمقروء
//   Future<bool> readNotification(final String id) async {
//     final response = await putRequest(
//       path: '/PutERPNotificationLog',
//       body: {
//         'BodyParam': {'CustomerId': customerId, 'NotificationId': id},
//       },
//     );
//
//     if (!isOk(response)) {
//       return false;
//     }
//
//     final jsonResponse = decodeResponse(response);
//     if (jsonResponse is num) return jsonResponse >= 1;
//     return false;
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

import '../app_all/BaseRepo.dart';
import 'notification_model.dart';

class NotificationsRepo extends BaseRepo {
  // ============================================================
  // ✅ Helper: يجيب الـ customerNo من SharedPreferences
  // ============================================================
  Future<int> _getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();

    final customerNo =
        prefs.getString('user_customer_no') ??
        prefs.getString('user_Customer_No') ??
        prefs.getString('user_id') ??
        prefs.getString('user_Customer_No');

    return int.tryParse(customerNo ?? '') ?? 1;
  }

  // ============================================================
  // ✅ جلب الإشعارات
  // ============================================================
  Future<List<AppNotification>> fetchNotifications({
    required int page,
    bool? read,
    int pageSize = 20,
  }) async {
    final customerId = await _getCustomerId();

    final response = await getRequest(
      path: '/GetERPNotificationLogSearch',
      queryParams: {
        'CustomerId': customerId,
        'IsRead': read ?? false,
        'PageIndex': page,
        'PageSize': pageSize,
      },
    );

    if (!isOk(response)) {
      throw Exception('Failed to fetch notifications');
    }

    final data = decodeResponse(response);
    if (data == null) return [];

    return parseList<AppNotification>(data, (e) => AppNotification.fromJson(e));
  }

  // ============================================================
  // ✅ تعليم إشعار كمقروء
  // ============================================================
  Future<bool> readNotification(final String id) async {
    final customerId = await _getCustomerId();

    final response = await putRequest(
      path: '/PutERPNotificationLog',
      body: {
        'BodyParam': {'CustomerId': customerId, 'NotificationId': id},
      },
    );

    if (!isOk(response)) {
      return false;
    }

    final jsonResponse = decodeResponse(response);
    if (jsonResponse is num) return jsonResponse >= 1;
    return false;
  }
}
