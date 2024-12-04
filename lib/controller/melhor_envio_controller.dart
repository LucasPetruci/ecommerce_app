import 'dart:convert';

import '../service/melhor_envio_service.dart';

class MelhorEnvioController {
  final MelhorEnvioService _melhorEnvioService = MelhorEnvioService();

  Future<List<Map<String, dynamic>>> shipmentCalculate(
      {required String toPostalCode}) async {
    try {
      final result = await _melhorEnvioService.shipmentCalculate(
          toPostalCode: toPostalCode);

      final List<dynamic> response = jsonDecode(result);

      final List<Map<String, dynamic>> shippingOptions = response.map((option) {
        return {
          'name': option['name'] ?? 'Nome não disponível',
          'picture': option['company']?['picture'] ??
              'https://via.placeholder.com/150',
          'price': option['price'] ?? 'Preço não disponível',
          'delivery_time': option['delivery_time'] ?? 'Tempo não disponível',
        };
      }).toList();

      return shippingOptions;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
