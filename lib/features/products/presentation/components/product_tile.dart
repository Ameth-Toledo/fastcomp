import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../providers/products_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          AppRoutes.productDetail,
          arguments: product,
        );
        if (result == true && context.mounted) {
          context.read<ProductsProvider>().fetchProducts();
        }
      },
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProductThumbnail(product: product),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brand.toUpperCase(),
                  style: const TextStyle(fontSize: 10, letterSpacing: 1, color: Colors.black45),
                ),
                const SizedBox(height: 2),
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _StockBar(stock: product.stock),
                    const SizedBox(width: 6),
                    Text(
                      '${product.stock}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    if (product.specs.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Text(
                        product.specs.first.toUpperCase(),
                        style: const TextStyle(fontSize: 10, color: Colors.black45, letterSpacing: 0.5),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${product.price.toInt()}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (product.featured)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  color: const Color(0xFFC8F135),
                  child: const Text(
                    '* DESTAC.',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}

class _ProductThumbnail extends StatelessWidget {
  final Product product;

  const _ProductThumbnail({required this.product});

  @override
  Widget build(BuildContext context) {
    final bg = _categoryColor(product.category);
    final categoryAbbrev = _categoryAbbrev(product.category);
    final brandAbbrev = product.brand.substring(0, product.brand.length.clamp(0, 3)).toUpperCase();

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        width: 68,
        height: 68,
        child: product.imageUrl != null
            ? Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => _fallbackThumbnail(bg, categoryAbbrev, brandAbbrev),
              )
            : _fallbackThumbnail(bg, categoryAbbrev, brandAbbrev),
      ),
    );
  }

  Widget _fallbackThumbnail(Color bg, String categoryAbbrev, String brandAbbrev) {
    return Stack(
      children: [
        Container(color: bg),
        CustomPaint(size: const Size(68, 68), painter: _HatchPainter()),
        Positioned(
          top: 6,
          left: 6,
          child: Text(categoryAbbrev,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
        Positioned(
          bottom: 6,
          right: 6,
          child: Text(brandAbbrev,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
      ],
    );
  }

  Color _categoryColor(ProductCategory category) => switch (category) {
        ProductCategory.audio => const Color(0xFFB8D8F8),
        ProductCategory.computacion => const Color(0xFFCFC8F0),
        ProductCategory.movil => const Color(0xFFF0C8C8),
        ProductCategory.smarthome => const Color(0xFFF0DEB8),
        ProductCategory.fotografia => const Color(0xFFF0F0B8),
        ProductCategory.accesorios => const Color(0xFFDDDDDD),
      };

  String _categoryAbbrev(ProductCategory category) => switch (category) {
        ProductCategory.audio => 'AUD',
        ProductCategory.computacion => 'CMP',
        ProductCategory.movil => 'MOV',
        ProductCategory.smarthome => 'SHM',
        ProductCategory.fotografia => 'FOT',
        ProductCategory.accesorios => 'ACC',
      };
}

class _StockBar extends StatelessWidget {
  final int stock;

  const _StockBar({required this.stock});

  Color get _color {
    if (stock == 0) return Colors.red;
    if (stock <= 5) return Colors.orange;
    return const Color(0xFF4CAF50);
  }

  @override
  Widget build(BuildContext context) {
    final fraction = (stock / 50).clamp(0.0, 1.0);
    return SizedBox(
      width: 56,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: fraction,
          backgroundColor: Colors.black12,
          valueColor: AlwaysStoppedAnimation<Color>(_color),
        ),
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.5;
    const step = 9.0;
    for (double i = -size.height; i < size.width; i += step) {
      canvas.drawLine(Offset(i, size.height), Offset(i + size.height, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
