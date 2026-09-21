// class OrderModel {
//   final String transactionNumber;
//   final String branchName;
//   final String date;
//   final String transactionType;
//   final double subtotal;
//   final double discount;
//   final double total;
//   final List<OrderItemModel> items;
//   final String barcode;
//
//   const OrderModel({
//     required this.transactionNumber,
//     required this.branchName,
//     required this.date,
//     required this.transactionType,
//     required this.subtotal,
//     required this.discount,
//     required this.total,
//     required this.items,
//     required this.barcode,
//   });
// }
//
// class OrderItemModel {
//   final String name;
//   final double price;
//   final int quantity;
//
//   const OrderItemModel({
//     required this.name,
//     required this.price,
//     required this.quantity,
//   });
//
//   double get total => price * quantity;
// }

// lib/data/models/order_model.dart

// lib/data/models/order_model.dart

// lib/order/OrderModel.dart

// import 'order_item.dart';
//
// class OrderModel {
//   // ============================================================
//   // مفاتيح مطلوبة لجلب التفاصيل من الـ API
//   // ============================================================
//   final int? transId; // Trans_ID
//   final int? transYear; // Trans_Year
//   final int? transBranch; // Trans_Branch
//   final int? transWarehouse; // Trans_Warehouse
//   final int? transPos; // Trans_POS
//   final int? transType; // Trans_Type  (1 = فاتورة، 2 = مرتجع)
//
//   // ============================================================
//   // بيانات العرض
//   // ============================================================
//   final String transactionNumber; // Trans_OrderNo أو Trans_ID
//   final String branchName; // Branch_Name
//   final String date; // Trans_Date (نص)
//   final String transactionType; // وصف النوع (فاتورة / مرتجع)
//   final double subtotal; // Sub_Total
//   final double discount; // Discount_Value
//   final double total; // Net_Total
//   final String barcode; // Barcode
//
//   // ============================================================
//   // الأصناف
//   // ============================================================
//   final List<OrderItem> items;
//
//   // ============================================================
//   // JSON الأصلي (للاحتياط والوصول لأي حقل غير معرّف)
//   // ============================================================
//   final Map<String, dynamic> rawJson;
//
//   const OrderModel({
//     this.transId,
//     this.transYear,
//     this.transBranch,
//     this.transWarehouse,
//     this.transPos,
//     this.transType,
//     required this.transactionNumber,
//     required this.branchName,
//     required this.date,
//     required this.transactionType,
//     required this.subtotal,
//     required this.discount,
//     required this.total,
//     required this.barcode,
//     required this.items,
//     this.rawJson = const {},
//   });
//
//   // ============================================================
//   // FROM JSON
//   // ============================================================
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       // المفاتيح المطلوبة للتفاصيل
//       transId: _toInt(json['Trans_ID']),
//       transYear: _toInt(json['Trans_Year']),
//       transBranch: _toInt(json['Trans_Branch']),
//       transWarehouse: _toInt(json['Trans_Warehouse']),
//       transPos: _toInt(json['Trans_POS']),
//       transType: _toInt(json['Trans_Type']),
//
//       // بيانات العرض
//       transactionNumber: _toStr(
//         json['Trans_OrderNo'] ?? json['Trans_ID'] ?? '',
//       ),
//       // branchName: _toStr(json['Branch_Name'] ?? json['BranchName'] ?? ''),
//       branchName: _toStr(
//         json['Branch_Desc'] ?? json['Branch_Name'] ?? json['BranchName'] ?? '',
//       ),
//       date: _toStr(json['Trans_Date'] ?? json['Date'] ?? ''),
//       transactionType: _resolveTypeLabel(json),
//       subtotal: _toDouble(json['Sub_Total'] ?? json['SubTotal']),
//       discount: _toDouble(json['Discount_Value'] ?? json['Discount']),
//       total: _toDouble(json['Net_Total'] ?? json['Total'] ?? json['NetTotal']),
//       barcode: _toStr(json['Barcode'] ?? ''),
//
//       // الأصناف
//       items: _parseItems(json['Items'] ?? json['items']),
//
//       // الأصل
//       rawJson: json,
//     );
//   }
//
//   // ============================================================
//   // TO JSON
//   // ============================================================
//   Map<String, dynamic> toJson() {
//     // نبني قائمة الأصناف بنوع صريح List<Map<String, dynamic>>
//     final itemsJson = <Map<String, dynamic>>[
//       for (final item in items) item.toJson(),
//     ];
//
//     return {
//       // المفاتيح الأساسية
//       'Trans_ID': transId,
//       'Trans_Year': transYear,
//       'Trans_Branch': transBranch,
//       'Trans_Warehouse': transWarehouse,
//       'Trans_POS': transPos,
//       'Trans_Type': transType,
//
//       // بيانات العرض
//       'Trans_OrderNo': transactionNumber,
//       'Branch_Name': branchName,
//       'Trans_Date': date,
//       'Sub_Total': subtotal,
//       'Discount_Value': discount,
//       'Net_Total': total,
//       'Barcode': barcode,
//
//       // الأصناف (بالمفتاحين للتوافق)
//       'Items': itemsJson,
//       'items': itemsJson,
//
//       // وصف النوع (للتوافق مع fromJson)
//       'Trans_Type_Desc': transactionType,
//     };
//   }
//
//   // ============================================================
//   // COPY WITH
//   // ============================================================
//   OrderModel copyWith({
//     int? transId,
//     int? transYear,
//     int? transBranch,
//     int? transWarehouse,
//     int? transPos,
//     int? transType,
//     String? transactionNumber,
//     String? branchName,
//     String? date,
//     String? transactionType,
//     double? subtotal,
//     double? discount,
//     double? total,
//     String? barcode,
//     List<OrderItem>? items,
//     Map<String, dynamic>? rawJson,
//   }) {
//     return OrderModel(
//       transId: transId ?? this.transId,
//       transYear: transYear ?? this.transYear,
//       transBranch: transBranch ?? this.transBranch,
//       transWarehouse: transWarehouse ?? this.transWarehouse,
//       transPos: transPos ?? this.transPos,
//       transType: transType ?? this.transType,
//       transactionNumber: transactionNumber ?? this.transactionNumber,
//       branchName: branchName ?? this.branchName,
//       date: date ?? this.date,
//       transactionType: transactionType ?? this.transactionType,
//       subtotal: subtotal ?? this.subtotal,
//       discount: discount ?? this.discount,
//       total: total ?? this.total,
//       barcode: barcode ?? this.barcode,
//       items: items ?? this.items,
//       rawJson: rawJson ?? this.rawJson,
//     );
//   }
//
//   // ============================================================
//   // HELPERS
//   // ============================================================
//
//   /// هل يحتوي على كل المفاتيح المطلوبة لجلب التفاصيل؟
//   bool get hasDetailsKeys =>
//       transId != null &&
//       transYear != null &&
//       transBranch != null &&
//       transWarehouse != null &&
//       transPos != null &&
//       transType != null;
//
//   /// هل هو مرتجع؟ (Trans_Type == 2)
//   bool get isReturn => transType == 2;
//
//   /// نوع الحركة كنص عربي (1 = فاتورة، 2 = مرتجع)
//   static String _resolveTypeLabel(Map<String, dynamic> json) {
//     final direct = json['Trans_Type_Desc'] ?? json['TransactionType'];
//     if (direct != null && direct.toString().trim().isNotEmpty) {
//       return direct.toString();
//     }
//     final t = _toInt(json['Trans_Type']);
//     if (t == 1) return 'فاتورة';
//     if (t == 2) return 'مرتجع';
//     return '';
//   }
//
//   static List<OrderItem> _parseItems(dynamic value) {
//     if (value is List) {
//       return value
//           .whereType<Map>()
//           .map((e) => OrderItem.fromJson(Map<String, dynamic>.from(e)))
//           .toList();
//     }
//     return const [];
//   }
//
//   static int? _toInt(dynamic v) {
//     if (v == null) return null;
//     if (v is int) return v;
//     if (v is num) return v.toInt();
//     return int.tryParse(v.toString().trim());
//   }
//
//   static double _toDouble(dynamic v) {
//     if (v == null) return 0;
//     if (v is double) return v;
//     if (v is num) return v.toDouble();
//     return double.tryParse(v.toString().trim()) ?? 0;
//   }
//
//   static String _toStr(dynamic v) => v?.toString().trim() ?? '';
//
//   // ============================================================
//   // EQUALITY
//   // ============================================================
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is OrderModel &&
//           runtimeType == other.runtimeType &&
//           transId == other.transId &&
//           transYear == other.transYear &&
//           transBranch == other.transBranch &&
//           transWarehouse == other.transWarehouse &&
//           transPos == other.transPos &&
//           transType == other.transType &&
//           transactionNumber == other.transactionNumber;
//
//   @override
//   int get hashCode => Object.hash(
//     transId,
//     transYear,
//     transBranch,
//     transWarehouse,
//     transPos,
//     transType,
//     transactionNumber,
//   );
//
//   @override
//   String toString() =>
//       'OrderModel('
//       'transId: $transId, '
//       'number: $transactionNumber, '
//       'type: $transactionType, '
//       'total: $total, '
//       'items: ${items.length})';
// }

// lib/order/OrderModel.dart

import 'order_item.dart';

class OrderModel {
  // ============================================================
  // مفاتيح مطلوبة لجلب التفاصيل من الـ API
  // ============================================================
  final int? transId; // Trans_ID
  final int? transYear; // Trans_Year
  final int? transBranch; // Trans_Branch
  final int? transWarehouse; // Trans_Warehouse
  final int? transPos; // Trans_POS
  final int? transType; // Trans_Type  (1 = فاتورة، 2 = مرتجع)

  // ============================================================
  // بيانات العرض
  // ============================================================
  final String transactionNumber; // Trans_OrderNo
  final String branchName; // Branch_Desc
  final String date; // Trans_StartTime (ISO كامل)
  final String timeOnly; // Trans_Date (وقت فقط "04:20 PM")
  final String transactionType; // Trans_Type_Desc

  // ============================================================
  // المبالغ (الأسماء الحقيقية في الـ API)
  // ============================================================
  final double subtotal; // Trans_SubTotalBeforeDiscount
  final double discount; // Trans_Discount_Value
  final double discountPercent; // Trans_Discount_Percent
  final double tax; // Trans_Tax_Value
  final double total; // Trans_Grand_Total_With_Service

  // ============================================================
  // بيانات إضافية
  // ============================================================
  final String barcode; // Barcode أو Trans_ID
  final String customerName; // Customer_Desc
  final String paymentMethod; // Payment_Methods
  final String orderType; // OrderTypeDesc

  // ============================================================
  // الأصناف
  // ============================================================
  final List<OrderItem> items;

  // ============================================================
  // JSON الأصلي
  // ============================================================
  final Map<String, dynamic> rawJson;

  const OrderModel({
    this.transId,
    this.transYear,
    this.transBranch,
    this.transWarehouse,
    this.transPos,
    this.transType,
    required this.transactionNumber,
    required this.branchName,
    required this.date,
    required this.timeOnly,
    required this.transactionType,
    required this.subtotal,
    required this.discount,
    required this.discountPercent,
    required this.tax,
    required this.total,
    required this.barcode,
    required this.customerName,
    required this.paymentMethod,
    required this.orderType,
    required this.items,
    this.rawJson = const {},
  });

  // ============================================================
  // FROM JSON
  // ============================================================
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      // المفاتيح المطلوبة للتفاصيل
      transId: _toInt(json['Trans_ID']),
      transYear: _toInt(json['Trans_Year']),
      transBranch: _toInt(json['Trans_Branch']),
      transWarehouse: _toInt(json['Trans_Warehouse']),
      transPos: _toInt(json['Trans_POS']),
      transType: _toInt(json['Trans_Type']),

      // بيانات العرض
      transactionNumber: _toStr(
        json['Trans_OrderNo'] ?? json['Trans_ID'] ?? '',
      ),

      // ✅ الفرع — Branch_Desc هو الاسم الصحيح
      branchName: _toStr(
        json['Branch_Desc'] ?? json['Branch_Name'] ?? json['BranchName'] ?? '',
      ),

      // ✅ التاريخ الكامل من Trans_StartTime (يحتوي تاريخ + وقت)
      date: _toStr(
        json['Trans_StartTime'] ??
            json['Trans_ZDate'] ??
            json['Trans_Date'] ??
            json['Date'] ??
            '',
      ),

      // ✅ الوقت فقط
      timeOnly: _toStr(json['Trans_Date'] ?? ''),

      transactionType: _resolveTypeLabel(json),

      // ✅ Subtotal — Trans_SubTotalBeforeDiscount
      subtotal: _toDouble(
        json['Trans_SubTotalBeforeDiscount'] ??
            json['Sub_Total'] ??
            json['SubTotal'],
      ),

      // ✅ Discount — Trans_Discount_Value
      discount: _toDouble(
        json['Trans_Discount_Value'] ??
            json['Discount_Value'] ??
            json['Discount'],
      ),

      // ✅ Discount % — Trans_Discount_Percent
      discountPercent: _toDouble(json['Trans_Discount_Percent'] ?? 0),

      // ✅ Tax — Trans_Tax_Value
      tax: _toDouble(json['Trans_Tax_Value'] ?? 0),

      // ✅ Total — Trans_Grand_Total_With_Service
      total: _toDouble(
        json['Trans_Grand_Total_With_Service'] ??
            json['Net_Total'] ??
            json['Total'] ??
            json['NetTotal'],
      ),

      barcode: _toStr(json['Barcode'] ?? json['Trans_ID'] ?? ''),

      customerName: _toStr(json['Customer_Desc'] ?? ''),
      paymentMethod: _toStr(json['Payment_Methods'] ?? ''),
      orderType: _toStr(json['OrderTypeDesc'] ?? ''),

      // الأصناف
      items: _parseItems(json['Items'] ?? json['items']),

      // الأصل
      rawJson: json,
    );
  }

  // ============================================================
  // TO JSON
  // ============================================================
  Map<String, dynamic> toJson() {
    final itemsJson = <Map<String, dynamic>>[
      for (final item in items) item.toJson(),
    ];

    return {
      // المفاتيح الأساسية
      'Trans_ID': transId,
      'Trans_Year': transYear,
      'Trans_Branch': transBranch,
      'Trans_Warehouse': transWarehouse,
      'Trans_POS': transPos,
      'Trans_Type': transType,

      // بيانات العرض
      'Trans_OrderNo': transactionNumber,
      'Branch_Desc': branchName,
      'Trans_StartTime': date,
      'Trans_Date': timeOnly,
      'Trans_Type_Desc': transactionType,

      // المبالغ
      'Trans_SubTotalBeforeDiscount': subtotal,
      'Trans_Discount_Value': discount,
      'Trans_Discount_Percent': discountPercent,
      'Trans_Tax_Value': tax,
      'Trans_Grand_Total_With_Service': total,

      // إضافية
      'Barcode': barcode,
      'Customer_Desc': customerName,
      'Payment_Methods': paymentMethod,
      'OrderTypeDesc': orderType,

      // الأصناف
      'Items': itemsJson,
      'items': itemsJson,
    };
  }

  // ============================================================
  // COPY WITH
  // ============================================================
  OrderModel copyWith({
    int? transId,
    int? transYear,
    int? transBranch,
    int? transWarehouse,
    int? transPos,
    int? transType,
    String? transactionNumber,
    String? branchName,
    String? date,
    String? timeOnly,
    String? transactionType,
    double? subtotal,
    double? discount,
    double? discountPercent,
    double? tax,
    double? total,
    String? barcode,
    String? customerName,
    String? paymentMethod,
    String? orderType,
    List<OrderItem>? items,
    Map<String, dynamic>? rawJson,
  }) {
    return OrderModel(
      transId: transId ?? this.transId,
      transYear: transYear ?? this.transYear,
      transBranch: transBranch ?? this.transBranch,
      transWarehouse: transWarehouse ?? this.transWarehouse,
      transPos: transPos ?? this.transPos,
      transType: transType ?? this.transType,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      branchName: branchName ?? this.branchName,
      date: date ?? this.date,
      timeOnly: timeOnly ?? this.timeOnly,
      transactionType: transactionType ?? this.transactionType,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      discountPercent: discountPercent ?? this.discountPercent,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      barcode: barcode ?? this.barcode,
      customerName: customerName ?? this.customerName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderType: orderType ?? this.orderType,
      items: items ?? this.items,
      rawJson: rawJson ?? this.rawJson,
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  /// todo new now
  String get compositeBarcode {
    final parts = <String>[
      (transYear ?? '').toString(),
      (transBranch ?? '').toString(),
      (transWarehouse ?? '').toString(),
      (transPos ?? '').toString(),
      (transType ?? '').toString(),
      (transId ?? '').toString(),
    ];

    final concatenated = parts.map((p) => p.trim()).join();

    if (concatenated.isEmpty) {
      return barcode.isNotEmpty ? barcode : transactionNumber;
    }

    return concatenated;
  }

  /// هل يحتوي على كل المفاتيح المطلوبة لجلب التفاصيل؟
  bool get hasDetailsKeys =>
      transId != null &&
      transYear != null &&
      transBranch != null &&
      transWarehouse != null &&
      transPos != null &&
      transType != null;

  /// هل هو مرتجع؟ (Trans_Type == 2)
  bool get isReturn => transType == 2;

  /// التاريخ والوقت بصيغة جميلة للعرض
  /// مثال: "06 Nov, 2025 • 3:27 PM"
  String get formattedDateTime {
    final parsed = DateTime.tryParse(date);
    if (parsed != null) {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      final hour = parsed.hour > 12
          ? parsed.hour - 12
          : (parsed.hour == 0 ? 12 : parsed.hour);
      final period = parsed.hour >= 12 ? 'PM' : 'AM';
      final minute = parsed.minute.toString().padLeft(2, '0');
      return '${months[parsed.month - 1]} ${parsed.day}, '
          '${parsed.year} • $hour:$minute $period';
    }
    return timeOnly.isNotEmpty ? timeOnly : date;
  }

  /// نوع الحركة كنص عربي (1 = فاتورة، 2 = مرتجع)
  static String _resolveTypeLabel(Map<String, dynamic> json) {
    final direct = json['Trans_Type_Desc'] ?? json['TransactionType'];
    if (direct != null && direct.toString().trim().isNotEmpty) {
      return direct.toString();
    }
    final t = _toInt(json['Trans_Type']);
    if (t == 1) return 'فاتورة';
    if (t == 2) return 'مرتجع';
    return '';
  }

  static List<OrderItem> _parseItems(dynamic value) {
    if (value is List) {
      return value
          .whereType<Map>()
          .map((e) => OrderItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return const [];
  }

  static int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString().trim());
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString().trim()) ?? 0;
  }

  static String _toStr(dynamic v) => v?.toString().trim() ?? '';

  // ============================================================
  // EQUALITY
  // ============================================================
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModel &&
          runtimeType == other.runtimeType &&
          transId == other.transId &&
          transYear == other.transYear &&
          transBranch == other.transBranch &&
          transWarehouse == other.transWarehouse &&
          transPos == other.transPos &&
          transType == other.transType &&
          transactionNumber == other.transactionNumber;

  @override
  int get hashCode => Object.hash(
    transId,
    transYear,
    transBranch,
    transWarehouse,
    transPos,
    transType,
    transactionNumber,
  );

  @override
  String toString() =>
      'OrderModel('
      'id: $transId, '
      'no: $transactionNumber, '
      'branch: $branchName, '
      'subtotal: $subtotal, '
      'discount: $discount, '
      'tax: $tax, '
      'total: $total, '
      'items: ${items.length})';
}
