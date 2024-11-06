import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/controller/addtocart_screen_controller.dart';
import 'package:shoppingcart/controller/discover_screen_controller.dart';
import 'package:shoppingcart/controller/product_detailsScreen_controller.dart';
import 'package:shoppingcart/view/onboarding_screen/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DiscoverScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsscreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddtocartScreenController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen(),
      ),
    );
  }
}
