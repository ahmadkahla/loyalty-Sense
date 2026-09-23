import 'dart:convert';

import 'package:flutter/foundation.dart';

class AppNotification {
  final String id;
  final String? titleEn;
  final String? titleAr;
  final String? bodyEn;
  final String? bodyAr;
  final DateTime time;
  final bool isRead;
  final Map<String, dynamic> data;

  const AppNotification({
    required this.id,
    this.titleEn,
    this.titleAr,
    this.bodyEn,
    this.bodyAr,
    required this.time,
    required this.isRead,
    this.data = const {},
  });

  String? get link {
    if (data['screen'] == 'url') {
      final url = data['url'] ?? data['id'];
      if (url != null) {
        final str = url.toString().trim();
        if (str.isNotEmpty && str != 'null') return str;
      }
    }

    final raw =
        data['link'] ??
        data['url'] ??
        data['Link'] ??
        data['Url'] ??
        data['deeplink'] ??
        data['deepLink'];

    if (raw == null) return null;
    final str = raw.toString().trim();
    if (str.isEmpty || str == 'null') return null;
    return str;
  }

  bool get hasLink => link != null;

  String? getLocalizedTitle(String languageCode) {
    if (languageCode == 'ar') {
      return titleAr ?? titleEn;
    }
    return titleEn ?? titleAr;
  }

  String? getLocalizedBody(String languageCode) {
    if (languageCode == 'ar') {
      return bodyAr ?? bodyEn;
    }
    return bodyEn ?? bodyAr;
  }

  factory AppNotification.fromJson(final Map<String, dynamic> json) {
    debugPrint('═══════════════════════════════════════');
    debugPrint('📅 RAW SentDate: ${json['SentDate']}');
    debugPrint('🔗 RAW DataJSON: ${json['DataJSON']}');
    debugPrint('═══════════════════════════════════════');

    // ✅ قراءة DataJSON
    Map<String, dynamic> parseData() {
      final fromMap = json['data'];
      if (fromMap is Map) return Map<String, dynamic>.from(fromMap);

      final rawDataJson = json['DataJSON'];
      if (rawDataJson == null) return const {};

      final str = rawDataJson.toString().trim();
      if (str.isEmpty || str == 'null') return const {};

      try {
        final decoded = jsonDecode(str);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (e) {
        debugPrint('❌ فشل parse DataJSON: $e');
      }
      return const {};
    }

    final parsedData = parseData();
    debugPrint('✅ Parsed data: $parsedData');

    final parsedDate = _parseDate(json['SentDate']);

    return AppNotification(
      id: json['NotificationId']?.toString() ?? '',
      titleEn: json['MessageEnTitle']?.toString(),
      titleAr: json['MessageArTitle']?.toString(),
      bodyEn: json['MessageEnBody']?.toString(),
      bodyAr: json['MessageArBody']?.toString(),
      time: parsedDate,
      isRead: json['IsRead'] == true || json['IsRead'] == 1,
      data: parsedData,
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();

    if (value is int) {
      if (value <= 0) return DateTime.now();
      if (value < 100000000000) {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      }
      return DateTime.fromMillisecondsSinceEpoch(value);
    }

    if (value is double) return _parseDate(value.toInt());

    final str = value.toString().trim();
    if (str.isEmpty || str == '0' || str == 'null') return DateTime.now();

    if (str.startsWith('/Date(')) {
      final match = RegExp(r'/Date\((\d+)').firstMatch(str);
      if (match != null) {
        final ms = int.tryParse(match.group(1) ?? '');
        if (ms != null && ms > 0) {
          return DateTime.fromMillisecondsSinceEpoch(ms);
        }
      }
      return DateTime.now();
    }

    try {
      final date = DateTime.parse(str);
      if (date.year < 2000) {
        debugPrint('⚠️ تاريخ قديم: $date — استخدام now()');
        return DateTime.now();
      }
      return date;
    } catch (e) {
      debugPrint('❌ فشل parse: $str — $e');
      return DateTime.now();
    }
  }

  AppNotification copyWith({
    String? id,
    String? titleEn,
    String? titleAr,
    String? bodyEn,
    String? bodyAr,
    DateTime? time,
    bool? isRead,
    Map<String, dynamic>? data,
  }) {
    return AppNotification(
      id: id ?? this.id,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      bodyEn: bodyEn ?? this.bodyEn,
      bodyAr: bodyAr ?? this.bodyAr,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
    );
  }

  factory AppNotification.fake() {
    return AppNotification(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      titleEn: 'Notification title',
      titleAr: 'عنوان الإشعار',
      bodyEn: 'This is the notification description',
      bodyAr: 'هذا وصف الإشعار',
      time: DateTime.now(),
      isRead: false,
    );
  }
}
