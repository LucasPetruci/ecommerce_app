import 'package:ecommerce_app/app_router.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'components/scrollBehaviorModified.dart';
import 'controller/melhor_envio_controller.dart';

Future<void> main() async {
  if (!kReleaseMode) {
    await dotenv.load(fileName: "../.env");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => MelhorEnvioController()),
      ],
      child: ScrollConfiguration(
        behavior: ScrollBehaviorModified(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
