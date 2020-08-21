import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import '../models/cart.dart';

class CartPdt extends StatelessWidget {
  final String id;
  //final String productId;
  final double price;
  //final int quantity;
  final String name;

  CartPdt(this.id, this.price, this.name);

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
    //child:
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Card(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return CircularProgressIndicator();
            }
            else if (state is CartLoaded) {
              ListView.builder(
                  itemCount: state.cartItem.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          child: FittedBox(child: Text('\$')),
                        ),
                        title: Text(state.cartItem[index].name),
                        //subtitle: Text('Total: $${(price * quantity)}'),
                        //trailing: Text(' x'),
                      ));
            }
            else if(state is CartError){
              return Container();
            }
            //return Text('Something went wrong!');
          },
        ),
      ),
    );
  }
}
