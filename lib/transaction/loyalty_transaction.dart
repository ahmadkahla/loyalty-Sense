enum TransactionType {
  incoming(1),
  outgoing(2);

  const TransactionType(this.value);
  final int value;
}

class LoyaltyTransaction {
  final int transYear;
  final int transBranch;
  final int transWarehouse;
  final int transPos;
  final int transId;
  final TransactionType transType;
  final int cardTransType;
  final int transOrderType;
  final DateTime transDate;
  final String loyaltyCardCode;
  final int loyaltyCustomerNo;
  final num point;
  final String? orderTypeDesc;
  final String? customerDesc;
  final String? transTypeDesc;
  final String? loyaltyTransDesc;

  const LoyaltyTransaction({
    required this.transYear,
    required this.transBranch,
    required this.transWarehouse,
    required this.transPos,
    required this.transId,
    required this.transType,
    required this.cardTransType,
    required this.transOrderType,
    required this.transDate,
    required this.loyaltyCardCode,
    required this.loyaltyCustomerNo,
    required this.point,
    this.orderTypeDesc,
    this.customerDesc,
    this.transTypeDesc,
    this.loyaltyTransDesc,
  });

  factory LoyaltyTransaction.fromJson(final Map<String, dynamic> json) {
    final cardTransType = json['Card_Trans_Type'] ?? 1;
    final transType = TransactionType.values.firstWhere(
      (e) => e.value == cardTransType,
      orElse: () => TransactionType.incoming,
    );

    return LoyaltyTransaction(
      transYear: json['Trans_Year'] ?? 0,
      transBranch: json['Trans_Branch'] ?? 0,
      transWarehouse: json['Trans_Warehouse'] ?? 0,
      transPos: json['Trans_POS'] ?? 0,
      transId: json['Trans_ID'] ?? 0,
      transType: transType,
      cardTransType: cardTransType,
      transOrderType: json['Trans_OrderType'] ?? 0,
      transDate: _parseDate(json['Trans_Date']),
      loyaltyCardCode: json['Loyalty_Card_Code']?.toString() ?? '',
      loyaltyCustomerNo: json['Loyalty_Customer_No'] ?? 0,
      point: json['Point'] ?? 0,
      orderTypeDesc: json['OrderType_Desc'],
      customerDesc: json['Customer_Desc'],
      transTypeDesc: json['TransType_Dec'],
      loyaltyTransDesc: json['LoyaltyTrans_Dec'],
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
}
