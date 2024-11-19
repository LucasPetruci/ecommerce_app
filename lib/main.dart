import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:ecommerce_app/pages/intro_page.dart';
import 'package:ecommerce_app/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'components/scrollBehaviorModified.dart';
import 'pages/home_page.dart';

Future<void> main() async {
  // if (!kReleaseMode) {
  //   await dotenv.load(fileName: "../.env");
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const IntroPage(),
        ),
        GoRoute(
          path: '/productDetails',
          builder: (context, state) {
            final shoe = state.extra as Shoe;
            return ProductDetails(shoe: shoe);
          },
        ),
        GoRoute(
          path: '/homePage',
          builder: (context, state) {
            final index = state.extra as int?;
            return HomePage(indexNav: index ?? 0);
          },
        ),
      ],
    );

    return ChangeNotifierProvider(
      create: (context) => Cart(),
      builder: (context, child) => ScrollConfiguration(
        behavior: ScrollBehaviorModified(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      ),
    );
  }
}
