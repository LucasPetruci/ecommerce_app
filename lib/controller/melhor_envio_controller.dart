import 'package:flutter/material.dart';

import '../models/melhor_envio.dart';
import '../service/melhor_envio_service.dart';

class MelhorEnvioController with ChangeNotifier {
  List<MelhorEnvio> _shipmentOptions = [];
  bool _isLoading = false;

  List<MelhorEnvio> get shipmentOptions => _shipmentOptions;
  bool get isLoading => _isLoading;
  MelhorEnvioService melhorEnvioService = MelhorEnvioService();

  Future<void> shipmentCalculate({required String toPostalCode}) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();
    try {
      final options = await melhorEnvioService.shipmentCalculate(
          toPostalCode: toPostalCode);
      print('Options: $options');
      _shipmentOptions = options;
    } catch (e) {
      print('Erro ao calcular frete: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
