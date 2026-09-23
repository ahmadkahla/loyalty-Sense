// class AppSlide {
//   final int id;
//   final String image;
//   final String? title;
//   final String? description;
//   final String? action;
//   final int order;
//   final bool isActive;
//
//   const AppSlide({
//     required this.id,
//     required this.image,
//     this.title,
//     this.description,
//     this.action,
//     this.order = 0,
//     this.isActive = true,
//   });
//
//   factory AppSlide.fromJson(final Map<String, dynamic> json) {
//     return AppSlide(
//       id: json['id'] ?? json['Id'] ?? 0,
//       image: json['image'] ?? json['Image'] ?? json['ImageUrl'] ?? '',
//       title: json['title'] ?? json['Title'],
//       description: json['description'] ?? json['Description'],
//       action: json['action'] ?? json['Action'] ?? json['Link'],
//       order: json['order'] ?? json['Order'] ?? 0,
//       isActive: json['isActive'] ?? json['IsActive'] ?? true,
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:typed_data';
//
// class AppSlide {
//   final int id;
//   final String arabicDesc;
//   final String englishDesc;
//   final int linkType;
//   final String linkId;
//   final String arabicImage; // base64
//   final String englishImage; // base64
//   final bool isActive;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String bannerDesc;
//   final String linkTypeDesc;
//
//   const AppSlide({
//     required this.id,
//     required this.arabicDesc,
//     required this.englishDesc,
//     required this.linkType,
//     required this.linkId,
//     required this.arabicImage,
//     required this.englishImage,
//     required this.isActive,
//     this.startDate,
//     this.endDate,
//     required this.bannerDesc,
//     required this.linkTypeDesc,
//   });
//
//   factory AppSlide.fromJson(final Map<String, dynamic> json) {
//     return AppSlide(
//       id: json['Id'] ?? 0,
//       arabicDesc: json['ArabicDesc'] ?? '',
//       englishDesc: json['EnglishDesc'] ?? '',
//       linkType: json['LinkType'] ?? 0,
//       linkId: json['LinkId'] ?? '',
//       arabicImage: json['ArabicImage'] ?? '',
//       englishImage: json['EnglishImage'] ?? '',
//       isActive: json['IsActive'] ?? false,
//       startDate: json['StartDate'] != null
//           ? DateTime.tryParse(json['StartDate'].toString())
//           : null,
//       endDate: json['EndDate'] != null
//           ? DateTime.tryParse(json['EndDate'].toString())
//           : null,
//       bannerDesc: json['Banner_Desc'] ?? '',
//       linkTypeDesc: json['LinkType_Desc'] ?? '',
//     );
//   }
//
//   /// 👈⭐ فك تشفير الصورة العربية
//   Uint8List? get arabicImageBytes {
//     if (arabicImage.isEmpty) return null;
//     try {
//       return base64Decode(arabicImage);
//     } catch (_) {
//       return null;
//     }
//   }
//
//   /// 👈⭐ فك تشفير الصورة الإنجليزية
//   Uint8List? get englishImageBytes {
//     if (englishImage.isEmpty) return null;
//     try {
//       return base64Decode(englishImage);
//     } catch (_) {
//       return null;
//     }
//   }
//
//   /// 👈⭐ الصورة حسب اللغة الحالية
//   Uint8List? imageBytesFor(String languageCode) {
//     return languageCode == 'ar' ? arabicImageBytes : englishImageBytes;
//   }
// }

// import 'dart:convert';
// import 'dart:typed_data';
//
// class AppSlide {
//   final int id;
//   final String arabicDesc;
//   final String englishDesc;
//   final int linkType;
//   final String linkId;
//   final String arabicImage;
//   final String englishImage;
//   final bool isActive;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String bannerDesc;
//   final String linkTypeDesc;
//
//   const AppSlide({
//     required this.id,
//     required this.arabicDesc,
//     required this.englishDesc,
//     required this.linkType,
//     required this.linkId,
//     required this.arabicImage,
//     required this.englishImage,
//     required this.isActive,
//     this.startDate,
//     this.endDate,
//     required this.bannerDesc,
//     required this.linkTypeDesc,
//   });
//
//   // ============================================================
//   // FROM JSON — محصّن ضد null
//   // ============================================================
//   factory AppSlide.fromJson(final Map<String, dynamic> json) {
//     return AppSlide(
//       id: _parseInt(json['Id']) ?? 0,
//       arabicDesc: _parseString(json['ArabicDesc']),
//       englishDesc: _parseString(json['EnglishDesc']),
//       linkType: _parseInt(json['LinkType']) ?? 0,
//       linkId: _parseString(json['LinkId']),
//       arabicImage: _parseString(json['ArabicImage']),
//       englishImage: _parseString(json['EnglishImage']),
//       isActive: _parseBool(json['IsActive']) ?? false,
//       startDate: _parseDate(json['StartDate']),
//       endDate: _parseDate(json['EndDate']),
//       bannerDesc: _parseString(json['Banner_Desc']),
//       linkTypeDesc: _parseString(json['LinkType_Desc']),
//     );
//   }
//
//   // ============================================================
//   // HELPERS
//   // ============================================================
//   static String _parseString(dynamic value) {
//     if (value == null) return '';
//     return value.toString();
//   }
//
//   static int? _parseInt(dynamic value) {
//     if (value == null) return null;
//     if (value is int) return value;
//     if (value is num) return value.toInt();
//     return int.tryParse(value.toString());
//   }
//
//   static bool? _parseBool(dynamic value) {
//     if (value == null) return null;
//     if (value is bool) return value;
//     final str = value.toString().toLowerCase();
//     if (str == 'true') return true;
//     if (str == 'false') return false;
//     return null;
//   }
//
//   static DateTime? _parseDate(dynamic value) {
//     if (value == null) return null;
//     return DateTime.tryParse(value.toString());
//   }
//
//   // ============================================================
//   // GETTERS — base64 → bytes
//   // ============================================================
//
//   /// فك تشفير الصورة العربية
//   Uint8List? get arabicImageBytes {
//     return _decodeBase64(arabicImage);
//   }
//
//   /// فك تشفير الصورة الإنجليزية
//   Uint8List? get englishImageBytes {
//     return _decodeBase64(englishImage);
//   }
//
//   /// فك تشفير عام مع حماية
//   Uint8List? _decodeBase64(String? base64Str) {
//     if (base64Str == null) return null;
//     if (base64Str.isEmpty) return null;
//     try {
//       return base64Decode(base64Str);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   /// الصورة حسب اللغة الحالية
//   Uint8List? imageBytesFor(String languageCode) {
//     return languageCode == 'ar' ? arabicImageBytes : englishImageBytes;
//   }
// }

import 'dart:convert';
import 'dart:typed_data';

class AppSlide {
  final int id;
  final String? arabicDesc;
  final String? englishDesc;
  final int? linkType;
  final String? linkId;
  final String? arabicImage;
  final String? englishImage;
  final bool? isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? bannerDesc;
  final String? linkTypeDesc;

  const AppSlide({
    required this.id,
    this.arabicDesc,
    this.englishDesc,
    this.linkType,
    this.linkId,
    this.arabicImage,
    this.englishImage,
    this.isActive,
    this.startDate,
    this.endDate,
    this.bannerDesc,
    this.linkTypeDesc,
  });

  factory AppSlide.fromJson(final Map<String, dynamic> json) {
    return AppSlide(
      id: _parseInt(json['Id']) ?? 0,
      arabicDesc: json['ArabicDesc']?.toString(),
      englishDesc: json['EnglishDesc']?.toString(),
      linkType: _parseInt(json['LinkType']),
      linkId: json['LinkId']?.toString(),
      arabicImage: json['ArabicImage']?.toString(),
      englishImage: json['EnglishImage']?.toString(),
      isActive: _parseBool(json['IsActive']),
      startDate: _parseDate(json['StartDate']),
      endDate: _parseDate(json['EndDate']),
      bannerDesc: json['Banner_Desc']?.toString(),
      linkTypeDesc: json['LinkType_Desc']?.toString(),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    final str = value.toString().toLowerCase();
    if (str == 'true') return true;
    if (str == 'false') return false;
    return null;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  Uint8List? get arabicImageBytes {
    final img = arabicImage;
    if (img == null || img.isEmpty) return null;
    try {
      return base64Decode(img);
    } catch (_) {
      return null;
    }
  }

  Uint8List? get englishImageBytes {
    final img = englishImage;
    if (img == null || img.isEmpty) return null;
    try {
      return base64Decode(img);
    } catch (_) {
      return null;
    }
  }

  Uint8List? imageBytesFor(String languageCode) {
    return languageCode == 'ar' ? arabicImageBytes : englishImageBytes;
  }

  String descFor(String languageCode) {
    if (languageCode == 'ar') return arabicDesc ?? '';
    return englishDesc ?? '';
  }

  bool get hasLink {
    if (linkType == null || linkType == 1) return false;

    if (linkId == null || linkId!.trim().isEmpty) return false;

    return true;
  }

  String? get externalLink {
    if (!hasLink) return null;

    if (linkId!.startsWith('http://') || linkId!.startsWith('https://')) {
      return linkId;
    }

    if (linkType == 4) {
      return linkId;
    }

    const baseUrl = 'https://sense.com/';
    switch (linkType) {
      case 2:
        return '$baseUrl/category/${linkId}';
      case 3:
        return '$baseUrl/product/${linkId}';
      default:
        return linkId;
    }
  }
}
