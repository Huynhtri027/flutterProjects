import 'package:foodDeliveryUI/models/food.dart';
import 'package:foodDeliveryUI/models/restaurant.dart';

class Order {
  final Restaurant restaurant;
  final Food food;
  final int quantity;
  final String date;

  Order({this.restaurant, this.food, this.quantity, this.date});
}