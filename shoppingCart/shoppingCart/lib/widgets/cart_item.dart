import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import 'package:shoppingCart/models/item.dart';


class CartPdt extends StatelessWidget {
  final String id;
  //final String productId;
  final double price;
  final int quantity;
  final String name;

  CartPdt(this.id, this.price, this.name, this.quantity);

  @override
  Widget build(BuildContext context) {
    // return Dismissible(
    //   //key: ValueKey(),
    //   direction: DismissDirection.endToStart,
    //   background: Container(
    //     color: Colors.red,
    //   ),
    //   onDismissed: (direction) {
    //     //Provider.of<Cart>(context, listen: false).removeItem(productId);
    //   },

    return Card(
                      child: ListTile(
                    leading:
                        CircleAvatar(child: FittedBox(child: Text('\$$price'))),
                    title: Text(name),
                    subtitle: Text('Total: \$${(price * quantity.toDouble())}'),
                    trailing: Text('$quantity x'),
                  ));
  }
}
