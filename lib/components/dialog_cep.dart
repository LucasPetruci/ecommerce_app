import 'package:ecommerce_app/controller/melhor_envio_controller.dart';
import 'package:flutter/material.dart';

class DialogCep extends StatefulWidget {
  final String cep;

  const DialogCep({Key? key, required this.cep}) : super(key: key);

  static void showCepDialog(BuildContext context, String cep) {
    showDialog(
      context: context,
      builder: (context) => DialogCep(cep: cep),
    );
  }

  @override
  State<DialogCep> createState() => _DialogCepState();
}

class _DialogCepState extends State<DialogCep> {
  late Future<List<Map<String, dynamic>>> _shippingResult;
  final MelhorEnvioController melhorEnvioController = MelhorEnvioController();
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _shippingResult = calculateShipping();
  }

  Future<List<Map<String, dynamic>>> calculateShipping() async {
    try {
      final result = await melhorEnvioController.shipmentCalculate(
        toPostalCode: widget.cep,
      );
      print('Resultado do cálculo de frete: $result');
      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Opções de frete'),
      content: FutureBuilder<List<Map<String, dynamic>>>(
        future: _shippingResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Text('Nenhuma opção de frete disponível.');
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final option = snapshot.data![index];
                  final String optionKey = option['name'] ?? '';
                  return RadioListTile(
                    title: Text(
                        '$optionKey  Preço: R\$ ${option['price']} Prazo: ${option['delivery_time']} dias'),
                    value: optionKey,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
