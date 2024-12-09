import 'package:flutter/material.dart';

import 'shoe.dart';

class Cart extends ChangeNotifier {
  //list of shoes for sale
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Zoom Freak',
      price: '236',
      imagePath: 'lib/images/zoomfreak.png',
      description:
          "Domine as quadras com o Nike Zoom Freak, o tênis exclusivo do astro Giannis Antetokounmpo. Com amortecimento Zoom Air responsivo e uma estrutura leve, ele oferece suporte e estabilidade para movimentos rápidos e explosivos. Ideal para jogadores que buscam velocidade, controle e estilo.",
    ),
    Shoe(
      name: 'Air Jordan',
      price: '220',
      imagePath: 'lib/images/AirJordan.png',
      description:
          "Leve o lendário estilo das quadras para as ruas com o Nike Air Jordan, o tênis que carrega o legado de Michael Jordan. Com design icônico e materiais premium, ele proporciona conforto, durabilidade e um visual incomparável. Perfeito para quem busca performance e elegância em um só modelo.",
    ),
    Shoe(
      name: 'KD Trey',
      price: '200',
      imagePath: 'lib/images/kdtrey.png',
      description:
          "Inspirado no jogo versátil de Kevin Durant, o Nike KD Trey 5 combina leveza e suporte para garantir agilidade e conforto em quadra. Com amortecimento responsivo e ajuste firme, é ideal para quem procura equilíbrio entre controle e velocidade, proporcionando máximo desempenho.",
    ),
    Shoe(
      name: 'Kyrie',
      price: '190',
      imagePath: 'lib/images/kyrie.png',
      description:
          "Desenvolvido para o estilo de jogo ágil e imprevisível de Kyrie Irving, o Nike Kyrie oferece tração superior e suporte direcionado para cortes rápidos e dribles desconcertantes. Seu design moderno e ajuste firme garantem conforto e performance, seja nas quadras ou nas ruas.",
    ),
  ];

  //list of items in user cart
  List<Shoe> userCart = [];

  double deliveryPrice = 0.0;

  //get list of shoes for sale
  List<Shoe> getShoeShop() {
    return shoeShop;
  }

  //get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  //get total price of items in cart
  String getTotalPrice() {
    double total = 0;
    for (var shoe in userCart) {
      total += double.parse(shoe.price);
    }
    total += deliveryPrice;
    return total.toString();
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

  //add delivery price to total
  void addDeliveryPrice(String price) {
    deliveryPrice = double.parse(price);
    notifyListeners();
  }

  //get delivery price
  double getDeliveryPrice() {
    return deliveryPrice;
  }

  //clear delivery price
  void clearDeliveryPrice() {
    deliveryPrice = 0.0;
    notifyListeners();
  }
}
