import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cart model test', () {
    final mockShoeShop = [
      Shoe(
        name: 'Mock Shoe 1',
        price: '100',
        imagePath: 'mock/image1.png',
        description: 'Mock description 1',
      ),
    ];
    test('should return the injected shoe shop list', () {
      //arrange
      final cart = Cart(initialShoeShop: mockShoeShop);

      //act
      final shoeShop = cart.getShoeShop();

      //assert
      expect(shoeShop.length, 1);
      expect(shoeShop.first.name, 'Mock Shoe 1');
      expect(shoeShop.first.price, '100');
      expect(shoeShop.first.imagePath, 'mock/image1.png');
      expect(shoeShop.first.description, 'Mock description 1');
    });

    // test('should get a shoe and add to cart', () {
    //   //arrange
    //   final cart = Cart();
    //   final shoe = mockShoeShop[0];

    //   //act
    //   cart.addItemToCart(shoe);

    //   //assert
    //   expect(cart.getUserCart().length, 1);
    //   expect(cart.getUserCart().first.name, 'Mock Shoe 1');
    //   expect(cart.getUserCart().first.price, '100');
    //   expect(cart.getUserCart().first.imagePath, 'mock/image1.png');
    //   expect(cart.getUserCart().first.description, 'Mock description 1');
    // });
  });
}
