import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodDeliveryUI/data/data.dart';
import 'package:foodDeliveryUI/models/restaurant.dart';
import 'package:foodDeliveryUI/screens/restaurant_screen.dart';
import 'package:foodDeliveryUI/widgets/rating_stars.dart';
import 'package:foodDeliveryUI/widgets/recent_orders.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildRestaurants() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RestaurantScreen(restaurant: restaurant))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: Colors.grey[200],
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    height: 150.0,
                    width: 150.0,
                    image: AssetImage(
                      restaurant.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingStars(restaurant.rating),
                    SizedBox(height: 4.0),
                    Text(
                      restaurant.address,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '0.2 miles away',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    });

    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Food Delivery UI')),
        leading: IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {}),
        actions: [
          FlatButton(
            child: Text(
              'Cart' + '(${currentUser.cart.length})',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        width: 1.0, color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      width: 0.8,
                      color: Colors.blue,
                    ),
                  ),
                  hintText: 'Search Food or Restaurants',
                  prefixIcon: InkWell(
                    child: Icon(Icons.search),
                    onTap: () {},
                  ),
                  suffixIcon: InkWell(
                    child: Icon(Icons.close),
                    onTap: () {},
                  )),
            ),
          ),
          RecentOrders(),
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Nearby Restaurants',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              _buildRestaurants(),
            ],
          )
        ],
      ),
    );
  }
}
