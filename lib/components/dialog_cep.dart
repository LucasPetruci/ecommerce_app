import 'package:ecommerce_app/controller/melhor_envio_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogCep extends StatefulWidget {
  final String cep;

  const DialogCep({super.key, required this.cep});

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
  late final MelhorEnvioController melhorEnvioController;

  @override
  void initState() {
    super.initState();

    melhorEnvioController =
        Provider.of<MelhorEnvioController>(context, listen: false);

    melhorEnvioController.addListener(_onShipmentOptionsUpdated);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      melhorEnvioController.shipmentCalculate(toPostalCode: widget.cep);
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
    return AlertDialog(
      title: const Text('Opções de frete'),
      content: Builder(
        builder: (context) {
          if (melhorEnvioController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
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
