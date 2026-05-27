import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/UiState/login_ui_state.dart';
import '../providers/login_provider.dart';
import 'password_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    context.read<LoginProvider>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<LoginProvider, bool>(
      (p) => p.state is LoginLoading,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CORREO', style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'tu@empresa.com',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 20),
        const Text('CONTRASEÑA', style: _labelStyle),
        const SizedBox(height: 6),
        PasswordField(controller: _passwordController),
        const SizedBox(height: 8),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isLoading ? null : _onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text('ENTRAR', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

const _labelStyle = TextStyle(fontSize: 11, letterSpacing: 1.5, color: Colors.black54);
