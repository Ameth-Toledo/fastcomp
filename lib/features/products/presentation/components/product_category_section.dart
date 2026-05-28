import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import 'product_tile.dart';

class ProductCategorySection extends StatelessWidget {
  final ProductCategory category;
  final List<Product> products;

  const ProductCategorySection({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _categoryColor(category),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${_displayName(category)} · ${products.length}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Divider(height: 1, thickness: 1, color: Colors.black12),
        ),
        ...products.map((p) => Column(
              children: [
                ProductTile(product: p),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(height: 1, thickness: 1, color: Colors.black12),
                ),
              ],
            )),
      ],
    );
  }

  String _displayName(ProductCategory category) => switch (category) {
        ProductCategory.audio => 'AUDIO',
        ProductCategory.computacion => 'COMPUTACIÓN',
        ProductCategory.movil => 'MÓVIL',
        ProductCategory.smarthome => 'SMARTHOME',
        ProductCategory.fotografia => 'FOTOGRAFÍA',
        ProductCategory.accesorios => 'ACCESORIOS',
      };

  Color _categoryColor(ProductCategory category) => switch (category) {
        ProductCategory.audio => Colors.blue,
        ProductCategory.computacion => Colors.purple,
        ProductCategory.movil => Colors.red,
        ProductCategory.smarthome => Colors.orange,
        ProductCategory.fotografia => Colors.amber,
        ProductCategory.accesorios => Colors.grey,
      };
}
