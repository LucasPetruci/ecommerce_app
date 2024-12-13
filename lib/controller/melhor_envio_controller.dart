import 'package:flutter/material.dart';

import '../models/melhor_envio.dart';
import '../service/melhor_envio_service.dart';

class MelhorEnvioController with ChangeNotifier {
  List<MelhorEnvio> _shipmentOptions = [];
  bool _isLoading = false;
  String? _currentPostalCode;

  List<MelhorEnvio> get shipmentOptions => _shipmentOptions;

  bool get isLoading => _isLoading;
  String? get currentPostalCode => _currentPostalCode;

  MelhorEnvioService melhorEnvioService = MelhorEnvioService();

  Future<void> shipmentCalculate({required String toPostalCode}) async {
    if (_isLoading) return;
    _isLoading = true;
    _currentPostalCode = toPostalCode;
    notifyListeners();
    try {
      final options = await melhorEnvioService.shipmentCalculate(
          toPostalCode: toPostalCode);

      _shipmentOptions = options.where((option) {
        return option.name.isNotEmpty &&
            option.price.isNotEmpty &&
            option.deliveryTime > 0;
      }).toList();
    } catch (e) {
      print('Erro ao calcular frete: $e');
      _shipmentOptions = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
