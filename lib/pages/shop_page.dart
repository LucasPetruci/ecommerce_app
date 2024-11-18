import 'package:ecommerce_app/components/shoe_tile.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:ecommerce_app/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ScrollController _scrollController = ScrollController();

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
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search',
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ],
            ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Mais escolhidos 🔥",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "See all",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10), //spacing
          Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              child: Row(
                children: List.generate(
                  value.getShoeShop().length,
                  (index) {
                    Shoe shoe = value.getShoeShop()[index];
                    return ShoeTile(
                      shoe: shoe,
                      onTap: () => addShoeToCart(shoe),
                      goToDetails: () {
                        context.go(
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
