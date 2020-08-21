import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Item {
  final String id;
  final String name;
  //final Color color;
  final String imgUrl;
  final double price;
  final String category;
  final String description;

  Item({this.id, this.name, this.imgUrl, this.price, this.category, this.description});

  // @override
  // List get props => [id, name, imgUrl, price, category, description];

  Map<String, Item> _items = {};

  Map<String, Item> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid, String name, double price, String category , String imgUrl, String description) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => Item(
              id: existingCartItem.id,
              name: existingCartItem.name,
              //quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price,
              imgUrl: existingCartItem.imgUrl,
              category: existingCartItem.category,
              description: existingCartItem.description));
    } else {
      _items.putIfAbsent(
          pdtid,
          () => Item(
                id: pdtid,
                name: name,
                //quantity: 1,
                price: price,
                imgUrl: imgUrl,
                category: category,
                description: description
              ));
    }
  }
}

// class CartItem extends Item{
//   Map<String, Item> _items = {};

//   CartItem(int id, String name, String imgUrl, int price, String category, String description) : super(id, name, imgUrl, price, category, description);

//   Map<String, Item> get items {
//     return {..._items};
//   }

//   int get itemCount {
//     return _items.length;
//   }

//   void addItem(String pdtid, String name, int price, String category , String imgUrl, String description) {
//     if (_items.containsKey(pdtid)) {
//       _items.update(
//           pdtid,
//           (existingCartItem) => CartItem(
//               id: DateTime.now().toString(),
//               name: existingCartItem.name,
//               quantity: existingCartItem.quantity + 1,
//               price: existingCartItem.price));
//     } else {
//       _items.putIfAbsent(
//           pdtid,
//           () => CartItem(
//                 name: name,
//                 id: DateTime.now().toString(),
//                 quantity: 1,
//                 price: price,
//               ));
//     }
//   }
// }