import 'package:flutter/material.dart';
import 'colors.dart';
import 'models/data.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _keyword = '';
  String _selectedCategory = 'Semua';
  final Set<int> _favoriteIds = {};
  

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', ...catalog.map((m) => m.type).toSet()];

    final filteredcatalog = catalog.where((product) {
      final matchKeyword = product.productName.toLowerCase().contains(_keyword.toLowerCase());
      final matchCategory = _selectedCategory == 'Semua' || product.type == _selectedCategory;
      return matchKeyword && matchCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog UNIQLO')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari product...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() => _keyword = value);
              },
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: categories.map((type) {
                final isSelected = type == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      type,
                      style: TextStyle(
                        color: isSelected ? kred : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: kwhite,
                    backgroundColor: Colors.white,
                    onSelected: (_) {
                      setState(() => _selectedCategory = type);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: filteredcatalog.isEmpty
                ? const Center(child: Text('product tidak ditemukan'))
                : ListView.builder(
                    itemCount: filteredcatalog.length,
                    itemBuilder: (context, index) {
                      final product = filteredcatalog[index];
                      final isFavorite = _favoriteIds.contains(product.id);
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Hero(
                              tag: 'product-${product.id}',
                              child: Image.network(
                                product.imageUrl,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(product.productName),
                          subtitle: Text('${product.type} • ${product.price} • Stok: ${product.stock} • Likes: ${product.likeCount}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isFavorite) {
                                      _favoriteIds.remove(product.id);
                                    } else {
                                      _favoriteIds.add(product.id);
                                    }
                                  });
                                },
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(product: product),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
