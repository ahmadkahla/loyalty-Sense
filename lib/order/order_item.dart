class OrderItem {
  final int id;
  final String name;
  final num price;
  final int quantity;
  final num total;

  const OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });

  factory OrderItem.fromJson(final Map<String, dynamic> json) {
    return OrderItem(
      id: (json['TransDetails_ID'] as num?)?.toInt() ?? 0,
      name:
          json['Item_Desc'] as String? ??
          json['TransDetails_ItemName'] as String? ??
          '',
      price: (json['TransDetails_Price'] as num?) ?? 0,
      quantity: (json['TransDetails_QTY'] as num?)?.toInt() ?? 0,
      total: (json['TransDetails_Total'] as num?) ?? 0,
    );
  }

  static List<OrderItem> collectParents(final List<Map<String, dynamic>> rows) {
    return rows.map(OrderItem.fromJson).toList();
  }
}
