import 'package:ecommerce_app/components/search_bar.dart';
import 'package:ecommerce_app/components/shoe_tile.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/scrollBehaviorModified.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  List<Shoe> _filteredShoes = [];

  @override
  void initState() {
    super.initState();
    final cart = Provider.of<Cart>(context, listen: false);
    _filteredShoes = cart.getShoeShop();
  }

  //filter shoes
  void _filterShoes(String query) {
    final cart = Provider.of<Cart>(context, listen: false);
    setState(() {
      if (query.isEmpty) {
        _filteredShoes = cart.getShoeShop();
      } else {
        _filteredShoes = cart
            .getShoeShop()
            .where(
                (shoe) => shoe.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          //search bar
          MySearchBar(
            placeholder: 'Buscar produtos...',
            controller: _searchController,
            onChanged: (value) {
              _filterShoes(value);
            },
          ),

          //message
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'everyone flies.. some fly longer than others',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          //Mais escolhidos

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Mais escolhidos 🔥",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),

          const SizedBox(height: 10), //spacing
          if (_filteredShoes.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Nenhum produto encontrado.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          else
            ScrollConfiguration(
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
                      _filteredShoes.length,
                      (index) {
                        Shoe shoe = _filteredShoes[index];
                        return ShoeTile(
                          shoe: shoe,
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
            ),

          const Padding(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
