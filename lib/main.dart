import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'models/product.dart';
import 'models/cart_item.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatefulWidget {
  const MiniKatalogApp({super.key});

  @override
  State<MiniKatalogApp> createState() => _MiniKatalogAppState();
}

class _MiniKatalogAppState extends State<MiniKatalogApp> {
  final List<CartItem> _cartItems = [];

  // Sepete ürün ekleme / varsa adedini artırma
  void _addToCart(Product product) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.product.id == product.id);
      if (index >= 0) {
        _cartItems[index].quantity++;
      } else {
        _cartItems.add(CartItem(product: product, quantity: 1));
      }
    });
  }

  // Miktar artırma
  void _incrementQuantity(CartItem cartItem) {
    setState(() {
      cartItem.quantity++;
    });
  }

  // Miktar azaltma (1 ise sepetten silme)
  void _decrementQuantity(CartItem cartItem) {
    setState(() {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        _cartItems.remove(cartItem);
      }
    });
  }

  // Doğrudan silme
  void _removeFromCart(CartItem cartItem) {
    setState(() {
      _cartItems.remove(cartItem);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        useMaterial3: true,
      ),
      home: HomeScreen(
        cartItems: _cartItems,
        onAddToCart: _addToCart,
        onIncrement: _incrementQuantity,
        onDecrement: _decrementQuantity,
        onRemoveFromCart: _removeFromCart,
        onClearCart: _clearCart,
      ),
    );
  }
}