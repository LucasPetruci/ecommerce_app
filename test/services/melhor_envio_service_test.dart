import 'dart:convert';
import 'package:ecommerce_app/models/melhor_envio.dart';
import 'package:ecommerce_app/service/melhor_envio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'melhor_envio_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("melhorEnvio shipmentCalculate", () {
    //arrange
    final expectedHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final client = MockClient();
    final service = MelhorEnvioService(client: client);
    const mockToPostalCode = '01001-000';
    const mockResponse = '''
     [
        {
          "name": "PAC",
          "price": "20.0",
          "delivery_time": 10
        }
      ]
      ''';

    final expectedBody = jsonEncode({
      'from': {'postal_code': service.fromPostalCode},
      'to': {'postal_code': mockToPostalCode},
      'package': {
        'weight': '4',
        'length': '17',
        'height': '0.3',
        'width': '12',
      },
    });

    //success test
    test('success - shipment Calculate', () async {
      when(client.post(
        Uri.parse(service.baseUrl),
        headers: argThat(equals(expectedHeaders), named: 'headers'),
        body: argThat(equals(expectedBody), named: 'body'),
      )).thenAnswer((_) async => http.Response(mockResponse, 200));

      //act
      final result =
          await service.shipmentCalculate(toPostalCode: mockToPostalCode);

      //assert
      expect(result.length, 1);
      expect(result, isA<List<MelhorEnvio>>());
      expect(result[0].name, 'PAC');
      expect(result[0].price, '20.0');
      expect(result[0].deliveryTime, 10);
    });

    //error test
    test('failure - shipment calulate', () async {
      when(client.post(
        Uri.parse(service.baseUrl),
        headers: argThat(equals(expectedHeaders), named: 'headers'),
        body: argThat(equals(expectedBody), named: 'body'),
      )).thenAnswer((_) async => http.Response('Error', 400));

      //act
      final result = service.shipmentCalculate(toPostalCode: mockToPostalCode);

      //assert
      expect(result, throwsException);
    });
  });
}
