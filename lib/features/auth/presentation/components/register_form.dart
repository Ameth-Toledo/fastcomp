import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../pages/UiState/register_ui_state.dart';
import '../providers/register_provider.dart';
import 'password_field.dart';
import 'password_validators.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _password = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() => _password = _passwordController.text);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _businessNameController.text.trim().isNotEmpty &&
      _emailController.text.trim().isNotEmpty &&
      _phoneController.text.trim().length == 10 &&
      _password.length >= 8;

  void _onSubmit() {
    context.read<RegisterProvider>().register(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          businessName: _businessNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _password,
          phone: _phoneController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<RegisterProvider, bool>(
      (p) => p.state is RegisterLoading,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('NOMBRE', style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: _firstNameController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Tu nombre',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 20),
        const Text('APELLIDO', style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: _lastNameController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Tu apellido',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 20),
        const Text('NEGOCIO', style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: _businessNameController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Nombre de tu negocio',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 20),
        const Text('CORREO', style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'tu@correo.com',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Lo usaremos para el inicio de sesión.',
          style: TextStyle(fontSize: 11, color: Colors.black45),
        ),
        const SizedBox(height: 20),
        const Text('TELÉFONO', style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          onChanged: (_) => setState(() {}),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            hintText: '10 dígitos',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            counterText: '',
          ),
        ),
        const SizedBox(height: 20),
        const Text('CONTRASEÑA', style: _labelStyle),
        const SizedBox(height: 6),
        PasswordField(controller: _passwordController),
        const SizedBox(height: 12),
        PasswordValidators(password: _password),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: (_isFormValid && !isLoading) ? _onSubmit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.black26,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text(
                    'CONTINUAR',
                    style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ],
    );
  }
}

const _labelStyle = TextStyle(fontSize: 11, letterSpacing: 1.5, color: Colors.black54);
