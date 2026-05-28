import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'summary_card.dart';

class ProductsHeader extends StatelessWidget {
  final List<Product> products;

  const ProductsHeader({super.key, required this.products});

  int get _outOfStock => products.where((p) => p.stock == 0).length;
  int get _featured => products.where((p) => p.featured).length;
  int get _lowStock => products.where((p) => p.stock > 0 && p.stock <= 5).length;
  double get _totalValue => products.fold(0, (sum, p) => sum + p.price * p.stock);

  String _monthLabel() {
    const months = [
      'ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO',
      'JULIO', 'AGOSTO', 'SEPTIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE',
    ];
    final now = DateTime.now();
    return '${months[now.month - 1]} ${now.year}';
  }

  String _formatValue(double value) {
    final str = value.toInt().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return '\$${buffer.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'INVENTARIO · ${_monthLabel()}',
                style: const TextStyle(fontSize: 11, letterSpacing: 1.2, color: Colors.black45),
              ),
              const Spacer(),
              if (_lowStock > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: const Color(0xFFC8F135),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        '$_lowStock STOCK BAJO',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${products.length} productos',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  label: 'AGOTADOS',
                  value: '$_outOfStock',
                  valueColor: _outOfStock > 0 ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(label: 'DESTACADOS', value: '$_featured'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SummaryCard(label: 'VALOR', value: _formatValue(_totalValue)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
