import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductDetails extends StatelessWidget {
  final Shoe shoe;

  const ProductDetails({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    const teste = String.fromEnvironment('TESTE', defaultValue: 'Valor padrão');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(shoe.name),
      ),
      body: Center(
        child: Text(
          'Informações do sapato: ${shoe.name}\nValor do teste: $teste',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
