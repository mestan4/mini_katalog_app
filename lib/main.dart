import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'models/product.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  // Sepetteki ürünlerin listesi (State Simülasyonu)
  final List<Product> _cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: HomeScreen(
        cartItems: _cartItems,
        onAddToCart: _addToCart,
        onRemoveFromCart: _removeFromCart,
      ),
    );
  }
}