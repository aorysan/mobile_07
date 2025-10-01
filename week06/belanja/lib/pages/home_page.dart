import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:belanja/models/item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Item> items = [
    Item(
      name: 'Gula',
      price: 12500,
      weight: 1000,
      brand: 'Gulaku',
      condition: 'Baru',
      stock: 100,
      category: 'Sembako',
      description: 'Gula pasir premium dengan kualitas terbaik',
      imageUrl: 'https://picsum.photos/id/1/200',
      rating: 5,
      seller: 'Toko Sembako Jaya',
      location: 'Malang',
    ),
    Item(
      name: 'Garam',
      price: 5000,
      weight: 500,
      brand: 'Cap Kapal',
      condition: 'Baru',
      stock: 50,
      category: 'Sembako',
      description: 'Garam beryodium berkualitas',
      imageUrl: 'https://picsum.photos/id/2/200',
      rating: 4,
      seller: 'Toko Sembako Jaya',
      location: 'Malang',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              context.go('/item', extra: item);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: item.name,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(item.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${item.price}',
                      style: const TextStyle(color: Colors.green, fontSize: 14),
                    ),
                    Text(item.location, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
