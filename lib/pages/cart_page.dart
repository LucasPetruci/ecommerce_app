import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/cart_item.dart';
import '../components/scrollBehaviorModified.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            const Text(
              'Carrinho',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            if (value.getUserCart().isEmpty)
              const Text(
                'Seu carrinho está vazio',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),

            ScrollConfiguration(
              behavior: ScrollBehaviorModified(),
              child: Expanded(
                child: ListView.builder(
                  itemCount: value.getUserCart().length,
                  itemBuilder: (context, index) {
                    //get individual shoe
                    Shoe individualShoe = value.getUserCart()[index];

                    //return the cart item
                    return CartItem(shoe: individualShoe);
                  },
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            // Campo para frete
            TextField(
              decoration: const InputDecoration(
                hintText: 'Calcular frete',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Atualizar o valor do frete
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Total: R\$ ${value.getTotalPrice()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
