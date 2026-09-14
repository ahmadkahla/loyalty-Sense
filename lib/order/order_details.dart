import 'order.dart';
import 'order_item.dart';

class OrderDetails {
  final Order order;
  final List<OrderItem> items;

  const OrderDetails({required this.order, required this.items});
}
