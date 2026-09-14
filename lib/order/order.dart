// class Order {
//   final int id;
//   final int orderNo;
//   final int branchId;
//   final String orderCompanyNo;
//   final String orderCompanyHashtag;
//   final String branchName;
//   final String orderNotes;
//   final bool isReservation;
//   final DateTime? reservationTime;
//   final DateTime dateTime;
//
//   final num total;
//   final num discount;
//   final String summary;
//   final String? paymentMethod;
//   final String transactionType; // Invoice / Return
//
//   const Order({
//     required this.id,
//     required this.orderNo,
//     required this.branchId,
//     required this.orderCompanyNo,
//     required this.orderCompanyHashtag,
//     required this.branchName,
//     required this.orderNotes,
//     required this.isReservation,
//     required this.reservationTime,
//
//     required this.dateTime,
//
//     required this.total,
//     required this.discount,
//     required this.summary,
//     required this.transactionType,
//     this.paymentMethod,
//   });
//
//   num get subtotal => total + discount;
//
//   bool get isReturn => transactionType.toLowerCase().trim() == 'return';
//
//   factory Order.fromJson(final Map<String, dynamic> json) {
//     return Order(
//       id: (json['Trans_ID'] as num?)?.toInt() ?? 0,
//       orderNo: (json['Trans_OrderNo'] as num?)?.toInt() ?? 0,
//       branchId: (json['Branch_ID'] as num?)?.toInt() ?? 0,
//       orderCompanyNo: json['Trans_OrderCompanyNo'] as String? ?? '',
//       orderCompanyHashtag: json['Trans_OrderCompanyHastag'] as String? ?? '',
//       branchName: json['Branch_Desc'] as String? ?? '',
//       orderNotes: json['Trans_OrderNote_Text'] as String? ?? '',
//       isReservation: ((json['Reservation'] as num?)?.toInt() ?? 0) == 1,
//       reservationTime: DateTime.tryParse(
//         json['Trans_ReservationTime'] as String? ?? '',
//       ),
//
//       dateTime:
//           DateTime.tryParse(json['Trans_StartTime'] as String? ?? '') ??
//           DateTime.now(),
//
//       total: (json['Trans_Grand_Total_With_Service'] as num?) ?? 0,
//       discount: (json['Trans_Discount_Value'] as num?) ?? 0,
//       summary: '',
//       paymentMethod: json['Trans_Payment_Method']?.toString(),
//       transactionType: _parseTransactionType(json),
//     );
//   }
//
//   static String _parseTransactionType(final Map<String, dynamic> json) {
//     final raw =
//         json['Trans_Type'] ??
//         json['Trans_TransactionType'] ??
//         json['TransactionType'] ??
//         json['Trans_IsReturn'] ??
//         json['IsReturn'] ??
//         json['Trans_Type_ID'] ??
//         json['Type'];
//
//     if (raw == null) return 'Invoice';
//
//     if (raw is num) return raw == 2 ? 'Return' : 'Invoice';
//
//     final str = raw.toString().toLowerCase().trim();
//     if (str.contains('return') || str == '2' || str == 'r') return 'Return';
//     return 'Invoice';
//   }
// }

class Order {
  final int id;
  final int orderNo;
  final int branchId;
  final String orderCompanyNo;
  final String orderCompanyHashtag;
  final String branchName;
  final String orderNotes;
  final bool isReservation;
  final DateTime? reservationTime;
  final DateTime dateTime;

  final num total;
  final num discount;
  final String summary;
  final String? paymentMethod;
  final String transactionType; // Invoice / Return

  const Order({
    required this.id,
    required this.orderNo,
    required this.branchId,
    required this.orderCompanyNo,
    required this.orderCompanyHashtag,
    required this.branchName,
    required this.orderNotes,
    required this.isReservation,
    required this.reservationTime,
    required this.dateTime,
    required this.total,
    required this.discount,
    required this.summary,
    required this.transactionType,
    this.paymentMethod,
  });

  num get subtotal => total + discount;

  bool get isReturn => transactionType.toLowerCase().trim() == 'return';

  factory Order.fromJson(final Map<String, dynamic> json) {
    return Order(
      id: (json['Trans_ID'] as num?)?.toInt() ?? 0,
      orderNo: (json['Trans_OrderNo'] as num?)?.toInt() ?? 0,
      branchId: (json['Branch_ID'] as num?)?.toInt() ?? 0,
      orderCompanyNo: json['Trans_OrderCompanyNo'] as String? ?? '',
      orderCompanyHashtag: json['Trans_OrderCompanyHastag'] as String? ?? '',
      branchName: json['Branch_Desc'] as String? ?? '',
      orderNotes: json['Trans_OrderNote_Text'] as String? ?? '',
      isReservation: ((json['Reservation'] as num?)?.toInt() ?? 0) == 1,
      reservationTime: DateTime.tryParse(
        json['Trans_ReservationTime'] as String? ?? '',
      ),
      dateTime:
          DateTime.tryParse(json['Trans_StartTime'] as String? ?? '') ??
          DateTime.now(),
      total: (json['Trans_Grand_Total_With_Service'] as num?) ?? 0,
      discount: (json['Trans_Discount_Value'] as num?) ?? 0,
      summary: '',
      paymentMethod: json['Trans_Payment_Method']?.toString(),
      transactionType: _parseTransactionType(json),
    );
  }

  static String _parseTransactionType(final Map<String, dynamic> json) {
    final raw =
        json['Trans_Type'] ??
        json['Trans_TransactionType'] ??
        json['TransactionType'] ??
        json['Trans_IsReturn'] ??
        json['IsReturn'] ??
        json['Trans_Type_ID'] ??
        json['Type'];

    if (raw == null) return 'Invoice';

    if (raw is num) return raw == 2 ? 'Return' : 'Invoice';

    final str = raw.toString().toLowerCase().trim();
    if (str.contains('return') || str == '2' || str == 'r') return 'Return';
    return 'Invoice';
  }
}
