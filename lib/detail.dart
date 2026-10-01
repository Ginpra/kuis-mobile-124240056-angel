import 'package:flutter/material.dart';
import 'colors.dart';
import 'models/data.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product-${product.id}',
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(product.type, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    'Ukuran: ${product.sizes.join(', ')}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 18,
                      color: kred,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Stok: ${product.stock}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Likes: ${product.likeCount}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontWeight: FontWeight.bold, color: kred),
                  ),
                  const SizedBox(height: 4),
                  Text(product.details),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
