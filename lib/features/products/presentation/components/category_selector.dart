import 'package:flutter/material.dart';

import '../../domain/entities/product_category.dart';

class CategorySelector extends StatelessWidget {
  final ProductCategory selected;
  final void Function(ProductCategory) onSelected;

  const CategorySelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.2,
      children: ProductCategory.values.map((cat) {
        final isSelected = cat == selected;
        return GestureDetector(
          onTap: () => onSelected(cat),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              border: Border.all(color: isSelected ? Colors.black : Colors.black12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : _categoryColor(cat),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _displayName(cat),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _displayName(ProductCategory cat) => switch (cat) {
        ProductCategory.audio => 'AUDIO',
        ProductCategory.computacion => 'COMPUTACIÓN',
        ProductCategory.movil => 'MÓVIL',
        ProductCategory.smarthome => 'SMART HOME',
        ProductCategory.fotografia => 'FOTOGRAFÍA',
        ProductCategory.accesorios => 'ACCESORIOS',
      };

  Color _categoryColor(ProductCategory cat) => switch (cat) {
        ProductCategory.audio => Colors.blue,
        ProductCategory.computacion => Colors.purple,
        ProductCategory.movil => Colors.red,
        ProductCategory.smarthome => Colors.green,
        ProductCategory.fotografia => Colors.orange,
        ProductCategory.accesorios => Colors.grey,
      };
}
