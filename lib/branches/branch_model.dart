import 'package:flutter/material.dart';

class Branch {
  final String id;
  final String displayName;

  final bool isOpen24;
  final TimeOfDay? openTime;
  final TimeOfDay? closeTime;

  final TimeOfDay allowOrderFrom;
  final TimeOfDay allowOrderTo;

  final double latitude;
  final double longitude;

  final String phone1;
  final String phone2;

  final String googleRateUrl;

  final int waitingTime;

  final Map<String, dynamic> rawData;

  const Branch({
    required this.id,
    required this.displayName,
    required this.isOpen24,
    required this.openTime,
    required this.closeTime,
    required this.allowOrderFrom,
    required this.allowOrderTo,
    required this.latitude,
    required this.longitude,
    required this.phone1,
    required this.phone2,
    required this.googleRateUrl,
    required this.waitingTime,
    this.rawData = const {},
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    TimeOfDay? parseTime(dynamic value) {
      if (value == null) return null;

      final text = value.toString().trim();
      if (text.isEmpty) return null;

      try {
        final upper = text.toUpperCase();
        final isPM = upper.contains('PM');
        final isAM = upper.contains('AM');

        final cleaned = text.replaceAll(RegExp(r'[AaPp][Mm]'), '').trim();

        final parts = cleaned.split(':');
        if (parts.length < 2) return null;

        var hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;

        if (isPM && hour < 12) hour += 12;
        if (isAM && hour == 12) hour = 0;

        return TimeOfDay(hour: hour.clamp(0, 23), minute: minute.clamp(0, 59));
      } catch (_) {
        return null;
      }
    }

    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    int parseInt(dynamic value) {
      if (value is num) return value.toInt();
      return int.tryParse(value?.toString() ?? '') ?? 0;
    }

    final openTime = parseTime(
      json['Open_Time'] ?? json['OpenTime'] ?? json['open_time'],
    );
    final closeTime = parseTime(
      json['Close_Time'] ?? json['CloseTime'] ?? json['close_time'],
    );

    return Branch(
      id: json['Branch_Code']?.toString() ?? '',
      displayName: json['Branch_Desc']?.toString() ?? '',
      isOpen24:
          json['Is24Hour'] == true ||
          json['Is24Hour']?.toString().toLowerCase() == 'true',
      openTime: openTime,
      closeTime: closeTime,
      allowOrderFrom: openTime ?? const TimeOfDay(hour: 6, minute: 0),
      allowOrderTo: closeTime ?? const TimeOfDay(hour: 23, minute: 0),
      latitude: parseDouble(json['Latitude']),
      longitude: parseDouble(json['Longitude']),
      phone1: json['Phone1']?.toString() ?? '',
      phone2: json['Phone2']?.toString() ?? '',
      googleRateUrl: json['ActKey']?.toString() ?? '',
      waitingTime: parseInt(json['WaitingTime']),
      rawData: Map<String, dynamic>.from(json),
    );
  }

  Branch copyWith({
    String? phone1,
    String? phone2,
    String? googleRateUrl,
    TimeOfDay? openTime,
    TimeOfDay? closeTime,
  }) {
    return Branch(
      id: id,
      displayName: displayName,
      isOpen24: isOpen24,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      allowOrderFrom: allowOrderFrom,
      allowOrderTo: allowOrderTo,
      latitude: latitude,
      longitude: longitude,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      googleRateUrl: googleRateUrl ?? this.googleRateUrl,
      waitingTime: waitingTime,
      rawData: rawData,
    );
  }

  bool get hasPhoneNumbers {
    return phone1.isNotEmpty || phone2.isNotEmpty;
  }

  String get primaryPhone {
    if (phone1.isNotEmpty) return phone1;
    return phone2;
  }

  TimeOfDay? fixedClosingTime() {
    final open = openTime;
    final close = closeTime;

    if (open == null || close == null) return null;

    if (close.hour < open.hour && close.period == DayPeriod.am) {
      return TimeOfDay(hour: close.hour + 24, minute: close.minute);
    }

    return close;
  }

  factory Branch.fake() {
    const time = TimeOfDay(hour: 10, minute: 0);

    return const Branch(
      id: '0',
      displayName: 'Loading branch...',
      isOpen24: false,
      openTime: time,
      closeTime: time,
      allowOrderFrom: time,
      allowOrderTo: time,
      latitude: 0,
      longitude: 0,
      phone1: '',
      phone2: '',
      googleRateUrl: '',
      waitingTime: 0,
    );
  }
}
