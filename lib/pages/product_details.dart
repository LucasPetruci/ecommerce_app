import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/scrollBehaviorModified.dart';
import '../components/shoe_tile.dart';

class ProductDetails extends StatelessWidget {
  final Shoe shoe;

  const ProductDetails({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    double price = double.parse(shoe.price);
    final ScrollController _scrollController = ScrollController();

    final String teste = kReleaseMode
        ? const String.fromEnvironment('TESTE', defaultValue: 'Valor padrão')
        : dotenv.env['TESTE'] ?? 'Valor local';
    //screen size
    final size = MediaQuery.of(context).size;

    void addShoeToCart(Shoe shoe) {
      Provider.of<Cart>(context, listen: false).addItemToCart(shoe);

      //alert the user, shoe successfully added to cart
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Success added!'),
          content: Text('Check your cart'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          shoe.name,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.black, height: 0.5)),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehaviorModified(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  child: Image.asset(shoe.imagePath,
                      height: 300, width: size.width),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        "R\$ ${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      //button
                      ElevatedButton(
                        onPressed: () {
                          //add shoe to cart
                          Provider.of<Cart>(context, listen: false)
                              .addItemToCart(shoe);
                          //alert the user, shoe successfully added to cart
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                                  Text('${shoe.name} adicionado com sucesso!'),
                              content: const Text('Verifique seu carrinho'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(10, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Adicionar ao carrinho',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                Column(
                  children: [
                    const Text(
                      'Sobre',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(shoe.description,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Outros produtos",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer<Cart>(
                      builder:
                          (BuildContext context, Cart value, Widget? child) {
                        return ScrollConfiguration(
                          behavior: ScrollBehaviorModified(),
                          child: Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              controller: _scrollController,
                              child: Row(
                                children: List.generate(
                                  // Filtra a lista para excluir o produto atual
                                  Provider.of<Cart>(context)
                                      .getShoeShop()
                                      .where((item) => item != shoe)
                                      .length,
                                  (index) {
                                    // Lista filtrada
                                    final filteredProducts =
                                        Provider.of<Cart>(context)
                                            .getShoeShop()
                                            .where((item) => item != shoe)
                                            .toList();
                                    final Shoe otherShoe =
                                        filteredProducts[index];

                                    return ShoeTile(
                                      shoe: otherShoe,
                                      onTap: () => addShoeToCart(shoe),
                                      goToDetails: () {
                                        context.push(
                                          '/productDetails',
                                          extra: shoe,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
