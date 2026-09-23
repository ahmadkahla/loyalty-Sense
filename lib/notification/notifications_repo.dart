import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_all/BaseRepo.dart';
import 'notification_model.dart';

class NotificationsRepo extends BaseRepo {
  NotificationsRepo();

  Future<String> _getCustomerId() async {
    debugPrint('═══════════════════════════════════════');
    debugPrint('🔍 _getCustomerId START');
    debugPrint('═══════════════════════════════════════');

    try {
      final box = GetStorage();
      debugPrint('📦 GetStorage keys: ${box.getKeys().toList()}');

      final possibleKeys = [
        'user_customer_no',
        'customerNo',
        'Customer_No',
        'customer_no',
        'CustomerNo',
        'user_id',
      ];

      for (final key in possibleKeys) {
        final value = box.read(key);
        if (value != null) {
          final str = value.toString().trim();
          if (str.isNotEmpty && str != '0' && str != 'null') {
            debugPrint('✅ CustomerId from GetStorage [$key]: $str');
            return str;
          }
        }
      }
    } catch (e) {
      debugPrint('❌ GetStorage error: $e');
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      debugPrint('💾 SharedPreferences keys: ${prefs.getKeys()}');

      final possibleKeys = [
        'user_customer_no',
        'customerNo',
        'Customer_No',
        'customer_no',
      ];

      for (final key in possibleKeys) {
        final value = prefs.getString(key);
        if (value != null) {
          final str = value.trim();
          if (str.isNotEmpty && str != '0') {
            debugPrint('✅ CustomerId from SharedPreferences [$key]: $str');
            return str;
          }
        }
      }
    } catch (e) {
      debugPrint('❌ SharedPreferences error: $e');
    }

    // ============================================================
    // 3) Fallback
    // ============================================================
    debugPrint('⚠️ CustomerId NOT FOUND — using 1');
    debugPrint('═══════════════════════════════════════');
    return '1';
  }

  Future<List<AppNotification>> fetchNotifications({
    required int page,
    bool? read,
    int pageSize = 20,
  }) async {
    try {
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

      return parseList<AppNotification>(
        data,
        (e) => AppNotification.fromJson(e),
      );
    } catch (e) {
      debugPrint('❌ fetchNotifications error: $e');
      rethrow;
    }
  }

  Future<bool> readNotification(final String id) async {
    try {
      final customerId = await _getCustomerId();

      final response = await putRequest(
        path: '/PutERPNotificationLog',
        body: {
          'BodyParam': {'CustomerId': customerId, 'NotificationId': id},
        },
      );

      if (!isOk(response)) return false;

      final json = decodeResponse(response);
      if (json is num) return json >= 1;
      return false;
    } catch (e) {
      debugPrint('❌ readNotification error: $e');
      return false;
    }
  }

  Future<bool> uploadNotificationToken({required String token}) async {
    try {
      final customerId = await _getCustomerId();

      final response = await postRequest(
        path: '/PostCustomerAppToken',
        body: {
          'BodyParam': {
            'DeviceType': Platform.isAndroid ? 1 : 0,
            'CustomerId': customerId,
            'Token': token,
            'AppLang': 1,
            'OperNo': 1,
          },
        },
      );

      if (!isOk(response)) return false;

      final json = decodeResponse(response);
      if (json is num) return json >= 1;
      return false;
    } catch (e) {
      debugPrint('❌ uploadNotificationToken error: $e');
      return false;
    }
  }
}
