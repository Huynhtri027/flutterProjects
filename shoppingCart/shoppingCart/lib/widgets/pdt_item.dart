import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_ecom/screens/pdt_dscreen.dart';
import 'package:provider/provider.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import 'package:shoppingCart/models/item.dart';
import '../models/products.dart';
//import '../models/cart.dart';

class PdtItem extends StatelessWidget {
  final Product items;
  final String id;
  final String name;
  final String imageUrl;
  

  PdtItem({this.id, this.name, this.imageUrl, @required this.items});
  @override
  Widget build(BuildContext context) {
    //int quantity=0;
    //final pdt = Provider.of<Product>(context);
    Item cartItem = Item(id: items.id, name: items.name, imgUrl: items.imgUrl,price: items.price, category: items.category, description: items.description,);
    
    //final cart = Provider.of<Cart>(context);
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      //Item cartItem = items as Item;
      if (state is CartLoading) {
        return CircularProgressIndicator();
      }
      if (state is CartLoaded) {
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridTile(
              child: Image.network(imageUrl),
              footer: GridTileBar(
                title: Text(name),
                trailing: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      //cartItem = items.name;
                      //++quantity;
                      print(items.id);
                      //print('previous' + cartItem.name);
                      cartItem.addItem(items.id, items.name, items.price, items.category, items.imgUrl, items.description);
                      //print(state.cartItem);
                      print('after' + cartItem.quantity.toString());
                      if(cartItem.id!=null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Item Added to Cart'),
                      ));
                      }
                      return context.bloc<CartBloc>().add(CartItemAdded(cartItem));
                      
                    }
                    //cart.addItem(pdt.id, pdt.name, pdt.price);
                    ),
                backgroundColor: Colors.black87,
              ),
            ),
          ),
        );
      }
      return CircularProgressIndicator();
    });
  }
}
