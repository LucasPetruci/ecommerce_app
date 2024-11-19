import 'package:ecommerce_app/models/shoe.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/intro_page.dart';
import 'package:ecommerce_app/pages/product_details.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
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
}
