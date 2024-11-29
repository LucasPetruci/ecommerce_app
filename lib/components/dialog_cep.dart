import 'package:flutter/material.dart';

import '../service/melhor_envio.dart';

class DialogCep extends StatefulWidget {
  final String cep;

  const DialogCep({super.key, required this.cep});

  @override
  State<DialogCep> createState() => _DialogCepState();

  static void showCepDialog(BuildContext context, String cep) {
    showDialog(
      context: context,
      builder: (context) => DialogCep(cep: cep),
    );
  }
}

Future<void> calculateShipping() async {
  try {
    final result =
        await MelhorEnvio().shipmentCalculate(toPostalCode: '90570020');
    print("result: $result");
  } catch (e) {
    print(e);
  }
}

class _DialogCepState extends State<DialogCep> {
  @override
  void initState() {
    super.initState();
    calculateShipping();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('CEP informado'),
      content: Text('O CEP informado é ${widget.cep}'),
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
