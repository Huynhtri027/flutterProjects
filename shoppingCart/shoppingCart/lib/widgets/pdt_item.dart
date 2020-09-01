import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingCart/blocs/cart_bloc/cart_bloc.dart';
import 'package:shoppingCart/models/item.dart';
import '../models/products.dart';

class PdtItem extends StatelessWidget {
  final Product items;
  final String id;
  final String name;
  final String imageUrl;
  final String category, description;
  final double price;

  PdtItem({
    this.id,
    this.name,
    this.imageUrl,
    this.category,
    this.price,
    this.description,
    this.items,
  });
  @override
  Widget build(BuildContext context) {
    Item cartItem = Item(
        id: items.id,
        name: items.name,
        imgUrl: items.imgUrl,
        price: items.price,
        category: items.category,
        description: items.description);
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
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
                      cartItem.addItem(items.id, items.name, items.price,
                          items.category, items.imgUrl, items.description);
                      if (cartItem.id != null) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Item Added to Cart'),
                        ));
                      }
                      return context
                          .bloc<CartBloc>()
                          .add(CartItemAdded(cartItem.items[items.id]));
                    }),
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
