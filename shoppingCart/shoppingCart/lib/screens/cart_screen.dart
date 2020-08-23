import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_ecom/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import 'package:shoppingCart/models/item.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
    Item items;
   
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Cart',
            style:
                TextStyle(fontSize: 30, color: Theme.of(context).accentColor),
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is CartLoading) {
            return CircularProgressIndicator();
          } else if (state is CartLoaded) {
            print('Length ' + state.cartItem.length.toString());
            return Container(
              width: double.infinity,
              height: 800.0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        
                        itemCount: state.cartItem.length,
                        itemBuilder: (ctx, i) => CartPdt(
                            state.cartItem.toList()[i].id,
                            //state.cartItem.toList()[i].quantity.toString(),
                            state.cartItem.toList()[i].price,
                            state.cartItem.toList()[i].items.values.elementAt(0).name,
                            //state.cartItem.toList()[i].name,
                            //state.cartItem.toList()[i].items.values.elementAt(0).quantity
                            state.cartItem.toList()[i].items.values.elementAt(0).quantity))
                  ),
                ],

                // CheckoutButton(
                //   cart: cart,
                // ),
                // FlatButton;
              ),
            );
          } else if (state is CartError) {
            return Container();
          }
          return CircularProgressIndicator();
          //return Text('Something went wrong!');
        }));
  }
}
