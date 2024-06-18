import 'package:flutter/material.dart';

import 'shoe.dart';

class Cart extends ChangeNotifier {
  //list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Zoom Freak',
      price: '236',
      imagePath: 'lib/images/zoomfreak.png',
      description: "teste",
    ),
    Shoe(
      name: 'Air Jordan',
      price: '220',
      imagePath: 'lib/images/AirJordan.png',
      description: "teste",
    ),
    Shoe(
      name: 'KD Trey',
      price: '200',
      imagePath: 'lib/images/kdtrey.png',
      description: "teste",
    ),
    Shoe(
      name: 'Kyrie',
      price: '190',
      imagePath: 'lib/images/kyrie.png',
      description: "teste",
    ),
  ];

  //list of items in user cart

  List<Shoe> userCart = [];

  //get list of shoes for sale

  List<Shoe> getShoeShop() {
    return shoeShop;
  }

  //get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  //add items to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  //remove items from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
