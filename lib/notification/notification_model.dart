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

  // ✅ الحصول على العنوان حسب اللغة
  String? getLocalizedTitle(String languageCode) {
    if (languageCode == 'ar') {
      return titleAr ?? titleEn;
    }
    return titleEn ?? titleAr;
  }

  // ✅ الحصول على الوصف حسب اللغة
  String? getLocalizedBody(String languageCode) {
    if (languageCode == 'ar') {
      return bodyAr ?? bodyEn;
    }
    return bodyEn ?? bodyAr;
  }

  factory AppNotification.fromJson(final Map<String, dynamic> json) {
    return AppNotification(
      id: json['NotificationId']?.toString() ?? '',
      titleEn: json['MessageEnTitle']?.toString(),
      titleAr: json['MessageArTitle']?.toString(),
      bodyEn: json['MessageEnBody']?.toString(),
      bodyAr: json['MessageArBody']?.toString(),
      time: _parseDate(json['SentDate']),
      isRead: json['IsRead'] == true || json['IsRead'] == 1,
      data: {},
    );
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
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

  // ✅ للاختبار (Skeleton Loading)
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
