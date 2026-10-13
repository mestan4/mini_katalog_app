import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> cartItems;
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveFromCart;

  HomeScreen({
    super.key,
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveFromCart,
  });

  // Raporda istenen API simülasyonu / ürün listesi
  final List<Product> dummyProducts = [
    Product(
      id: 1,
      title: 'AirPods Max',
      description: 'Yüksek kaliteli ses, Aktif Gürültü Engelleme ve Şeffaf Mod özelliklerine sahip kablosuz kulaklık.',
      price: 549.00,
      imageUrl: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=500',
      category: 'Audio',
    ),
    Product(
      id: 2,
      title: 'HomePod Mini',
      description: 'Kompakt tasarımda güçlü ses kalitesi sunan ve akıllı evinizi yöneten akıllı hoparlör.',
      price: 99.00,
      imageUrl: 'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?w=500',
      category: 'Audio',
    ),
    Product(
      id: 3,
      title: 'MacBook Pro 14"',
      description: 'M3 Pro çip ile üstün profesyonel performans ve Liquid Retina XDR ekran.',
      price: 1999.00,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500',
      category: 'Bilgisayar',
    ),
    Product(
      id: 4,
      title: 'iPhone 15 Pro',
      description: 'Titanyum kasa tasarımı, A17 Pro çip ve gelişmiş kamera sistemi.',
      price: 999.00,
      imageUrl: 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=500',
      category: 'Telefon',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cartItems: cartItems,
                        onRemoveFromCart: onRemoveFromCart,
                      ),
                    ),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Arama Kutusu
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Banner Kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.card_giftcard, size: 40, color: Colors.blueAccent),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'GIFT STORE',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Special offers for you',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // GridView ile Ürün Kartları
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = dummyProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                          onAddToCart: onAddToCart,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: Colors.grey[200], child: const Icon(Icons.image)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}