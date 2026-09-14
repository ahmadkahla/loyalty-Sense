class OrderModel {
  final String transactionNumber;
  final String branchName;
  final String date;
  final String transactionType;
  final double subtotal;
  final double discount;
  final double total;
  final List<OrderItemModel> items;
  final String barcode;

  const OrderModel({
    required this.transactionNumber,
    required this.branchName,
    required this.date,
    required this.transactionType,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.items,
    required this.barcode,
  });
}

class OrderItemModel {
  final String name;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}
