import 'package:flutter/material.dart';

class CartPdt extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String name;

  CartPdt(this.id, this.price, this.name, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: CircleAvatar(child: FittedBox(child: Text('\$$price'))),
      title: Text(name),
      subtitle: Text('Total: \$${(price * quantity.toDouble())}'),
      trailing: Text('$quantity x'),
    ));
  }
}
