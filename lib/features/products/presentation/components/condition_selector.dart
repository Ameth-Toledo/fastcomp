import 'package:flutter/material.dart';

import '../../domain/entities/product_condition.dart';

class ConditionSelector extends StatelessWidget {
  final ProductCondition selected;
  final void Function(ProductCondition) onSelected;

  const ConditionSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ProductCondition.values.map((cond) {
        final isSelected = cond == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(cond),
            child: Container(
              margin: EdgeInsets.only(
                right: cond != ProductCondition.values.last ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFC8F135) : Colors.white,
                border: Border.all(
                  color: isSelected ? const Color(0xFFC8F135) : Colors.black12,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                _displayName(cond),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: isSelected ? Colors.black : Colors.black54,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _displayName(ProductCondition cond) => switch (cond) {
        ProductCondition.nuevo => 'NUEVO',
        ProductCondition.reacondicionado => 'REACOND.',
        ProductCondition.segunda_mano => '2ª MANO',
      };
}
