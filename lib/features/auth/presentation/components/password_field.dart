import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: '••••••••',
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: TextButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          child: Text(
            _obscure ? 'VER' : 'OCULTAR',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
