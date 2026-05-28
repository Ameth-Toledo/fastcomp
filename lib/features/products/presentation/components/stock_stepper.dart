import 'package:flutter/material.dart';

class StockStepper extends StatelessWidget {
  final int value;
  final void Function(int) onChanged;

  const StockStepper({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepButton(
          label: '−',
          onTap: value > 0 ? () => onChanged(value - 1) : null,
        ),
        Expanded(
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black12),
              ),
            ),
            child: Text(
              '$value',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _StepButton(
          label: '+',
          onTap: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const _StepButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: onTap != null ? Colors.black : Colors.black26,
            ),
          ),
        ),
      ),
    );
  }
}
