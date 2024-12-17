import 'package:ecommerce_app/models/melhor_envio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MelhorEnvio Model Test', () {
    test("should create an instance with valid JSON", () {
      //arrange
      final json = {
        'name': 'Correios',
        'price': '10.00',
        'delivery_time': 5,
      };

      //act
      final melhorEnvio = MelhorEnvio.fromJson(json);

      //assert
      expect(melhorEnvio.name, 'Correios');
      expect(melhorEnvio.price, '10.00');
      expect(melhorEnvio.deliveryTime, 5);
    });

    test('should use default values when JSON fields are missing', () {
      //arrange
      final Map<String, dynamic> json = {};

      //act
      final melhorEnvio = MelhorEnvio.fromJson(json);

      //assert
      expect(melhorEnvio.name, '');
      expect(melhorEnvio.price, '');
      expect(melhorEnvio.deliveryTime, 0);
    });
  });
}
