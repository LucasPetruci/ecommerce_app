import 'package:flutter/material.dart';

class DialogCep extends StatelessWidget {
  final String cep;

  const DialogCep({super.key, required this.cep});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('CEP informado'),
      content: Text('O CEP informado é $cep'),
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

  static void showCepDialog(BuildContext context, String cep) {
    showDialog(
      context: context,
      builder: (context) => DialogCep(cep: cep),
    );
  }
}
