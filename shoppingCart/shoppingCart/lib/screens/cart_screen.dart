import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_ecom/models/orders.dart';
import 'package:provider/provider.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import '../models/cart.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context);
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
          }
          else if (state is CartLoaded) {
            print('Length ' + state.cartItem.length.toString());
            return Container(
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.cartItem.length,
                        itemBuilder: (ctx, i) => CartPdt(
                            state.cartItem.toList()[i].id,
                            state.cartItem.toList()[i].price,
                            state.cartItem.toList()[i].name)),
                  ),
                ],

                // CheckoutButton(
                //   cart: cart,
                // ),
                // FlatButton;
              ),
            );
          }
          else if(state is CartError){
              return Container();
            }
          //return Text('Something went wrong!');

        }
        ));
  }
}
