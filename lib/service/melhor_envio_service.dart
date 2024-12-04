import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MelhorEnvioService {
  final String baseUrl = dotenv.env['MELHOR_ENVIO_URL'] ?? '';

  final String fromPostalCode = dotenv.env['FROM_POSTAL_CODE'] ?? '';

  Future<String> shipmentCalculate({
    required String toPostalCode,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = {
      'from': {
        'postal_code': fromPostalCode,
      },
      'to': {
        'postal_code': toPostalCode,
      },
      'package': {
        'weight': dotenv.env['PACKAGE_WEIGHT'] ?? '1',
        'length': dotenv.env['PACKAGE_LENGTH'] ?? '16',
        'height': dotenv.env['PACKAGE_HEIGHT'] ?? '2',
        'width': dotenv.env['PACKAGE_WIDTH'] ?? '11',
      },
    };

    try {
      print('Body enviado ao proxy: $body');
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print('Resposta do proxy: ${response.body}');
        return response.body;
      } else {
        print('Erro do proxy: ${response.body}');
        throw Exception(
            'Erro ao calcular frete ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Erro geral: $e');
      throw Exception('Erro ao calcular frete: $e');
    }
  }
}
