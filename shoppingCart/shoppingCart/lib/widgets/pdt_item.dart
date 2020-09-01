import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_ecom/screens/pdt_dscreen.dart';
import 'package:provider/provider.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import 'package:shoppingCart/blocs/product_bloc/products_bloc.dart';
import 'package:shoppingCart/models/item.dart';
import '../models/products.dart';
//import '../models/cart.dart';

class PdtItem extends StatelessWidget {
  final Product items;
  final String id;
  final String name;
  final String imageUrl;
  final String category,description;
  double price;
  

  PdtItem({this.id, this.name, this.imageUrl, this.category, this.price, this.description, this.items,});
  @override
  Widget build(BuildContext context) {
    int quantity;
    //final pdt = Provider.of<Product>(context);
    
    Item cartItem = Item(id: items.id, name: items.name, imgUrl: items.imgUrl,price: items.price, category: items.category, description: items.description);
    //Item cartItem;
    //List cartList = [];
    
    
    //final cart = Provider.of<Cart>(context);
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      Product pdt ;
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
                      int quantity;
                     //print(id);
                      //print('previous' + cartItem.name);
                      //cartItem.addItem(pdt.id, pdt.name, pdt.price, pdt.category, pdt.imgUrl, pdt.description);
                      cartItem.addItem(items.id, items.name, items.price, items.category, items.imgUrl, items.description);
                      //print(cartItem.items);
                      //print(cartItem.items.values);
                      //print('after' + cartItem.quantity.toString());
                      if(cartItem.id!=null){
                        Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Item Added to Cart'),
                      ));
                      }
                      return context.bloc<CartBloc>().add(CartItemAdded(cartItem.items[items.id]));
                      
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
