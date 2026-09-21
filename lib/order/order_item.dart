// class OrderItem {
//   final int id;
//   final String name;
//   final num price;
//   final int quantity;
//   final num total;
//
//   const OrderItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     required this.total,
//   });
//
//   factory OrderItem.fromJson(final Map<String, dynamic> json) {
//     return OrderItem(
//       id: (json['TransDetails_ID'] as num?)?.toInt() ?? 0,
//       name:
//           json['Item_Desc'] as String? ??
//           json['TransDetails_ItemName'] as String? ??
//           '',
//       price: (json['TransDetails_Price'] as num?) ?? 0,
//       quantity: (json['TransDetails_QTY'] as num?)?.toInt() ?? 0,
//       total: (json['TransDetails_Total'] as num?) ?? 0,
//     );
//   }
//
//   static List<OrderItem> collectParents(final List<Map<String, dynamic>> rows) {
//     return rows.map(OrderItem.fromJson).toList();
//   }
// }

// lib/order/order_item.dart

// class OrderItem {
//   // ============================================================
//   // الحقول
//   // ============================================================
//   final int id; // TransDetails_ID
//   final String name; // TransDetails_ItemName / Item_Desc
//   final double price; // TransDetails_Price
//   final int quantity; // TransDetails_QTY
//   final double total; // TransDetails_Total (أو price × quantity)
//
//   const OrderItem({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     required this.total,
//   });
//
//   // ============================================================
//   // FROM JSON
//   // ============================================================
//   factory OrderItem.fromJson(final Map<String, dynamic> json) {
//     final price = _toDouble(json['TransDetails_Price']);
//     final qty = _toInt(json['TransDetails_QTY']);
//     final apiTotal = _toDoubleOrNull(json['TransDetails_Total']);
//
//     return OrderItem(
//       id: _toInt(json['TransDetails_ID']),
//       name: _pickString([
//         json['Item_Desc'],
//         json['TransDetails_ItemName'],
//         json['Item_Name'],
//       ]),
//       price: price,
//       quantity: qty,
//       // لو الـ API ما أرسل Total نحسبه تلقائياً
//       total: apiTotal ?? (price * qty),
//     );
//   }
//
//   // ============================================================
//   // TO JSON
//   // ============================================================
//   Map<String, dynamic> toJson() => {
//     'TransDetails_ID': id,
//     'TransDetails_ItemName': name,
//     'TransDetails_Price': price,
//     'TransDetails_QTY': quantity,
//     'TransDetails_Total': total,
//   };
//
//   // ============================================================
//   // COPY WITH
//   // ============================================================
//   OrderItem copyWith({
//     int? id,
//     String? name,
//     double? price,
//     int? quantity,
//     double? total,
//   }) {
//     return OrderItem(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       price: price ?? this.price,
//       quantity: quantity ?? this.quantity,
//       total: total ?? this.total,
//     );
//   }
//
//   // ============================================================
//   // COLLECT FROM ROWS
//   // ============================================================
//   /// يحوّل قائمة من `Map` (صفوف الـ API) إلى `List<OrderItem>`.
//   static List<OrderItem> collectParents(final List<Map<String, dynamic>> rows) {
//     return rows.map(OrderItem.fromJson).toList();
//   }
//
//   // ============================================================
//   // HELPERS (Parsing)
//   // ============================================================
//   static int _toInt(dynamic v) {
//     if (v == null) return 0;
//     if (v is int) return v;
//     if (v is num) return v.toInt();
//     return int.tryParse(v.toString().trim()) ?? 0;
//   }
//
//   static double _toDouble(dynamic v) => _toDoubleOrNull(v) ?? 0;
//
//   static double? _toDoubleOrNull(dynamic v) {
//     if (v == null) return null;
//     if (v is double) return v;
//     if (v is num) return v.toDouble();
//     return double.tryParse(v.toString().trim());
//   }
//
//   static String _pickString(List<dynamic> values) {
//     for (final v in values) {
//       if (v == null) continue;
//       final s = v.toString().trim();
//       if (s.isNotEmpty) return s;
//     }
//     return '';
//   }
//
//   // ============================================================
//   // EQUALITY
//   // ============================================================
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is OrderItem && runtimeType == other.runtimeType && id == other.id;
//
//   @override
//   int get hashCode => id.hashCode;
//
//   // ============================================================
//   // TO STRING (للـ debug)
//   // ============================================================
//   @override
//   String toString() =>
//       'OrderItem(id: $id, name: $name, price: $price, qty: $quantity, total: $total)';
// }

class OrderItem {
  // ============================================================
  // BASIC FIELDS
  // ============================================================

  final int id;
  final String name;

  /// الاسم العربي من الـ API
  final String arabicName;

  /// الاسم الإنجليزي من الـ API
  final String englishName;

  /// رقم المادة
  final int itemNo;

  /// Barcode المادة
  final String barcode;

  /// سعر الوحدة
  final double price;

  /// الكمية
  final int quantity;

  /// الإجمالي النهائي للمادة
  final double total;

  // ============================================================
  // EXTRA API FIELDS
  // ============================================================

  final double subtotalBeforeTax;

  final double discountPercent;

  final double discountValue;

  final double taxPercent;

  final double taxValue;

  final String note;

  // ============================================================
  // CONSTRUCTOR
  // ============================================================

  const OrderItem({
    required this.id,
    required this.name,
    this.arabicName = '',
    this.englishName = '',
    this.itemNo = 0,
    this.barcode = '',
    required this.price,
    required this.quantity,
    required this.total,
    this.subtotalBeforeTax = 0,
    this.discountPercent = 0,
    this.discountValue = 0,
    this.taxPercent = 0,
    this.taxValue = 0,
    this.note = '',
  });

  // ============================================================
  // FROM JSON
  // ============================================================

  factory OrderItem.fromJson(final Map<String, dynamic> json) {
    // ----------------------------------------------------------
    // Arabic Name
    // ----------------------------------------------------------

    final arabicName = _pickString([
      json['Trans_Item_Arabic_Desc'],
      json['Item_Arabic_Desc'],
      json['Item_Desc'],
    ]);

    // ----------------------------------------------------------
    // English Name
    // ----------------------------------------------------------

    final englishName = _pickString([
      json['Trans_Item_English_Desc'],
      json['Item_English_Desc'],
      json['Item_Name'],
    ]);

    // ----------------------------------------------------------
    // Display Name
    //
    // التطبيق عندك English، لذلك نعرض الإنجليزي أولًا.
    // إذا لم يوجد نستخدم العربي.
    // ----------------------------------------------------------

    final displayName = englishName.isNotEmpty ? englishName : arabicName;

    // ----------------------------------------------------------
    // ID
    //
    // الـ API الحالي يرجع Trans_Serial
    // ----------------------------------------------------------

    final id = _toInt(json['Trans_Serial'] ?? json['TransDetails_ID']);

    // ----------------------------------------------------------
    // ITEM NUMBER
    // ----------------------------------------------------------

    final itemNo = _toInt(json['Trans_Item_No']);

    // ----------------------------------------------------------
    // BARCODE
    // ----------------------------------------------------------

    final barcode = _pickString([
      json['Trans_Item_Barcode'],
      json['Item_Barcode'],
    ]);

    // ----------------------------------------------------------
    // QUANTITY
    //
    // API:
    // Trans_Quantity = 6.0
    // ----------------------------------------------------------

    final quantity = _toInt(json['Trans_Quantity'] ?? json['TransDetails_QTY']);

    // ----------------------------------------------------------
    // UNIT PRICE
    //
    // API:
    // Trans_Unit_Price = 2.5
    // ----------------------------------------------------------

    final price = _toDouble(
      json['Trans_Unit_Price'] ?? json['TransDetails_Price'],
    );

    // ----------------------------------------------------------
    // TOTAL
    //
    // API:
    // Trans_Grand_Total = 12.000000001
    // ----------------------------------------------------------

    final apiTotal = _toDoubleOrNull(
      json['Trans_Grand_Total'] ?? json['TransDetails_Total'],
    );

    final total = apiTotal ?? (price * quantity);

    // ----------------------------------------------------------
    // SUBTOTAL BEFORE TAX
    // ----------------------------------------------------------

    final subtotalBeforeTax = _toDouble(json['Trans_SubTotal_BeforeTax']);

    // ----------------------------------------------------------
    // DISCOUNT
    // ----------------------------------------------------------

    final discountPercent = _toDouble(json['Trans_DiscountPer']);

    final discountValue = _toDouble(json['Trans_DiscountValue']);

    // ----------------------------------------------------------
    // TAX
    // ----------------------------------------------------------

    final taxPercent = _toDouble(json['Trans_TaxPer']);

    final taxValue = _toDouble(json['Trans_TaxValue']);

    // ----------------------------------------------------------
    // NOTE
    // ----------------------------------------------------------

    final note = _pickString([json['Trans_Note']]);

    // ----------------------------------------------------------
    // RETURN
    // ----------------------------------------------------------

    return OrderItem(
      id: id,
      name: displayName,
      arabicName: arabicName,
      englishName: englishName,
      itemNo: itemNo,
      barcode: barcode,
      price: price,
      quantity: quantity,
      total: total,
      subtotalBeforeTax: subtotalBeforeTax,
      discountPercent: discountPercent,
      discountValue: discountValue,
      taxPercent: taxPercent,
      taxValue: taxValue,
      note: note,
    );
  }

  // ============================================================
  // TO JSON
  // ============================================================

  Map<String, dynamic> toJson() {
    return {
      'Trans_Serial': id,
      'Trans_Item_No': itemNo,
      'Trans_Item_Barcode': barcode,
      'Trans_Item_Arabic_Desc': arabicName,
      'Trans_Item_English_Desc': englishName,
      'Trans_Quantity': quantity,
      'Trans_Unit_Price': price,
      'Trans_SubTotal_BeforeTax': subtotalBeforeTax,
      'Trans_DiscountPer': discountPercent,
      'Trans_DiscountValue': discountValue,
      'Trans_TaxPer': taxPercent,
      'Trans_TaxValue': taxValue,
      'Trans_Grand_Total': total,
      'Trans_Note': note,
    };
  }

  // ============================================================
  // COPY WITH
  // ============================================================

  OrderItem copyWith({
    int? id,
    String? name,
    String? arabicName,
    String? englishName,
    int? itemNo,
    String? barcode,
    double? price,
    int? quantity,
    double? total,
    double? subtotalBeforeTax,
    double? discountPercent,
    double? discountValue,
    double? taxPercent,
    double? taxValue,
    String? note,
  }) {
    return OrderItem(
      id: id ?? this.id,
      name: name ?? this.name,
      arabicName: arabicName ?? this.arabicName,
      englishName: englishName ?? this.englishName,
      itemNo: itemNo ?? this.itemNo,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      subtotalBeforeTax: subtotalBeforeTax ?? this.subtotalBeforeTax,
      discountPercent: discountPercent ?? this.discountPercent,
      discountValue: discountValue ?? this.discountValue,
      taxPercent: taxPercent ?? this.taxPercent,
      taxValue: taxValue ?? this.taxValue,
      note: note ?? this.note,
    );
  }

  // ============================================================
  // COLLECT ITEMS FROM API ROWS
  // ============================================================

  static List<OrderItem> collectParents(final List<Map<String, dynamic>> rows) {
    return rows.map((row) => OrderItem.fromJson(row)).toList();
  }

  // ============================================================
  // PARSING HELPERS
  // ============================================================

  static int _toInt(dynamic value) {
    if (value == null) {
      return 0;
    }

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value.toString().trim()) ?? 0;
  }

  static double _toDouble(dynamic value) {
    return _toDoubleOrNull(value) ?? 0;
  }

  static double? _toDoubleOrNull(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is double) {
      return value;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString().trim());
  }

  static String _pickString(List<dynamic> values) {
    for (final value in values) {
      if (value == null) {
        continue;
      }

      final text = value.toString().trim();

      if (text.isNotEmpty) {
        return text;
      }
    }

    return '';
  }

  // ============================================================
  // EQUALITY
  // ============================================================

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OrderItem &&
            runtimeType == other.runtimeType &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  // ============================================================
  // DEBUG
  // ============================================================

  @override
  String toString() {
    return 'OrderItem('
        'id: $id, '
        'itemNo: $itemNo, '
        'name: $name, '
        'arabicName: $arabicName, '
        'englishName: $englishName, '
        'barcode: $barcode, '
        'price: $price, '
        'quantity: $quantity, '
        'total: $total, '
        'subtotalBeforeTax: $subtotalBeforeTax, '
        'discountPercent: $discountPercent, '
        'discountValue: $discountValue, '
        'taxPercent: $taxPercent, '
        'taxValue: $taxValue, '
        'note: $note'
        ')';
  }
}
