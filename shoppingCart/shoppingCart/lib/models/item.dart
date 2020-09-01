class Item {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  final String category;
  final String description;
  final int quantity;

  Item(
      {this.id,
      this.name,
      this.imgUrl,
      this.price,
      this.category,
      this.description,
      this.quantity});

  Map<String, Item> _items = {};

  Map<String, Item> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String pdtid, String name, double price, String category,
      String imgUrl, String description) {
    if (_items.containsKey(pdtid)) {
      _items.update(
          pdtid,
          (existingCartItem) => Item(
              id: existingCartItem.id,
              name: existingCartItem.name,
              quantity: existingCartItem.quantity + 1,
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
              quantity: 1,
              price: price,
              imgUrl: imgUrl,
              category: category,
              description: description));
    }
  }
}
