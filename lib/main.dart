import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:ecommerce_app/pages/intro_page.dart';
import 'package:ecommerce_app/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  await dotenv.load(fileName: "/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configurar as rotas do GoRouter
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const IntroPage(),
        ),
        GoRoute(
          path: '/productDetails', // Rota para detalhes do produto
          builder: (context, state) {
            final shoe = state.extra as Shoe;
            return ProductDetails(shoe: shoe);
          },
        ),
      ],
    );

    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router, // Integrar GoRouter ao MaterialApp
      ),
    );
  }
}
