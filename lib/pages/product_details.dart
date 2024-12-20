import 'package:ecommerce_app/components/input_formatters.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/dialog_cep.dart';
import '../components/scrollBehaviorModified.dart';
import '../components/shoe_tile.dart';

class ProductDetails extends StatelessWidget {
  final Shoe shoe;

  const ProductDetails({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    double price = double.parse(shoe.price);
    final ScrollController scrollController = ScrollController();
    final TextEditingController cepController = TextEditingController();

    // final String teste = kReleaseMode
    //     ? const String.fromEnvironment('TESTE', defaultValue: 'Valor padrão')
    //     : dotenv.env['TESTE'] ?? 'Valor local';
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

    void handleNavigateCepPage() async {
      const url =
          'https://buscacepinter.correios.com.br/app/endereco/index.php';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        context.replace('/homePage', extra: 1);
                      },
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.shopping_bag_rounded,
                            size: 30,
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              child: Consumer<Cart>(
                                builder: (context, cart, child) {
                                  final itemCount = cart.getUserCart().length;
                                  return itemCount > 0
                                      ? Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            itemCount.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  shoe.imagePath,
                  height: size.height * 0.3,
                  width: size.width,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "R\$ ${price.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
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
                                  title: Text(
                                      '${shoe.name} adicionado com sucesso!'),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Calcule o frete",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: size.width * 0.7,
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(9),
                                InputFormatters(formatter: formatCep),
                              ],
                              controller: cepController,
                              decoration: InputDecoration(
                                hintText: '00000-000',
                                border: const OutlineInputBorder(),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      String cep = cepController.text
                                          .replaceAll(RegExp(r'-'), '');
                                      DialogCep.showCepDialog(context, cep);
                                    },
                                    child: const Text(
                                      'Calcular',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Não sei meu CEP',
                              style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  //navigate to the CEP page
                                  handleNavigateCepPage();
                                },
                            ),
                          ),
                        ],
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
                            controller: scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
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
                                          extra: otherShoe,
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
