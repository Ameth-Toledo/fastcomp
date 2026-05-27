import 'package:flutter/material.dart';

class PasswordValidators extends StatelessWidget {
  final String password;

  const PasswordValidators({super.key, required this.password});

  bool get _hasMinLength => password.length >= 8;
  bool get _hasMixedCase =>
      password.contains(RegExp(r'[A-Z]')) && password.contains(RegExp(r'[a-z]'));
  bool get _hasNumber => password.contains(RegExp(r'[0-9]'));
  bool get _hasSymbol => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]'));

  bool get isValid => _hasMinLength && _hasMixedCase && _hasNumber && _hasSymbol;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 6,
      children: [
        _ValidatorItem(label: '8+ caracteres', valid: _hasMinLength),
        _ValidatorItem(label: 'Mayús. y minús.', valid: _hasMixedCase),
        _ValidatorItem(label: 'Un número', valid: _hasNumber),
        _ValidatorItem(label: 'Un símbolo', valid: _hasSymbol),
      ],
    );
  }
}

class _ValidatorItem extends StatelessWidget {
  final String label;
  final bool valid;

  const _ValidatorItem({required this.label, required this.valid});

  @override
  Widget build(BuildContext context) {
    final color = valid ? const Color(0xFF2E7D32) : Colors.black38;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          valid ? Icons.check_box : Icons.check_box_outline_blank,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}
