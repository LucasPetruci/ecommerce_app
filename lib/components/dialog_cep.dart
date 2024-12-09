import 'package:ecommerce_app/controller/melhor_envio_controller.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogCep extends StatefulWidget {
  final String? cep;

  const DialogCep({super.key, this.cep});

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
  String? selectedOption;
  String? errorMessage;

  late final MelhorEnvioController melhorEnvioController;

  @override
  void initState() {
    super.initState();

    melhorEnvioController =
        Provider.of<MelhorEnvioController>(context, listen: false);

    melhorEnvioController.addListener(_onShipmentOptionsUpdated);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      melhorEnvioController.shipmentCalculate(toPostalCode: widget.cep ?? '');
    });
  }

  @override
  void dispose() {
    super.dispose();
    melhorEnvioController.removeListener(_onShipmentOptionsUpdated);
  }

  void _onShipmentOptionsUpdated() {
    if (!melhorEnvioController.isLoading &&
        melhorEnvioController.shipmentOptions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma opção de frete disponível.')),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    if (melhorEnvioController.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (melhorEnvioController.shipmentOptions.isEmpty) {
      return const Center(child: Text('Nenhuma opção de frete disponível.'));
    } else {
      return AlertDialog(
        title: const Text('Opções de frete'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: melhorEnvioController.shipmentOptions.length,
            itemBuilder: (context, index) {
              final option = melhorEnvioController.shipmentOptions[index];
              return RadioListTile(
                title: Text(
                    '${option.name}  Preço: R\$ ${option.price} Prazo: ${option.deliveryTime} dias'),
                value: option.name,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    errorMessage = null;
                  });
                },
              );
            },
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (selectedOption == null) {
                    setState(() {
                      errorMessage = 'Por favor, selecione uma opção de frete.';
                    });
                    return;
                  }

                  final selectedOptionData = melhorEnvioController
                      .shipmentOptions
                      .firstWhere((option) => option.name == selectedOption);

                  // Adiciona o preço do frete ao carrinho
                  cart.addDeliveryPrice(selectedOptionData.price);

                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      );
    }
  }
}
