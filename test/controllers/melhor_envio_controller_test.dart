import 'package:ecommerce_app/controller/melhor_envio_controller.dart';
import 'package:ecommerce_app/models/melhor_envio.dart';
import 'package:ecommerce_app/service/melhor_envio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'melhor_envio_controller_test.mocks.dart';

@GenerateMocks([MelhorEnvioService])
void main() {
  group('MelhorEnvioController - shipmentCalculate', () {
    late MockMelhorEnvioService mockService;
    late MelhorEnvioController controller;

    const toPostalCode = '01001-000';

    setUp(() {
      mockService = MockMelhorEnvioService();
      controller = MelhorEnvioController();
      controller.melhorEnvioService = mockService;
    });

    //initial state
    test('should initialize with default values', () {
      expect(controller.shipmentOptions, []);
      expect(controller.isLoading, false);
      expect(controller.currentPostalCode, null);
    });

    //success test
    test('should load shipment options successfully', () async {
      //arrange

      final mockOptions = [
        MelhorEnvio(name: 'PAC', price: '20.0', deliveryTime: 10),
      ];

      when(mockService.shipmentCalculate(toPostalCode: toPostalCode))
          .thenAnswer((_) async => mockOptions);

      //act
      final future = controller.shipmentCalculate(toPostalCode: toPostalCode);

      //assert(loading)
      expect(controller.isLoading, true);

      await future;

      //assert
      expect(controller.isLoading, false);
      expect(controller.currentPostalCode, toPostalCode);
      expect(controller.shipmentOptions, equals(mockOptions));
    });

    //error test
    test('should handle errors when calculating shipment options', () async {
      //arrange
      when(mockService.shipmentCalculate(toPostalCode: toPostalCode))
          .thenThrow(Exception('Erro ao calcular frete'));

      //act
      await controller.shipmentCalculate(toPostalCode: toPostalCode);

      //assert
      expect(controller.isLoading, false);
      expect(controller.shipmentOptions, isEmpty);
      expect(controller.currentPostalCode, toPostalCode);
    });
  });
}
