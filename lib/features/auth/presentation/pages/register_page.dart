import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../shared/components/app_snackbar.dart';
import '../components/register_form.dart';
import '../components/register_header.dart';
import '../pages/UiState/register_ui_state.dart';
import '../providers/register_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(
        builder: (context, provider, _) {
          if (provider.state is RegisterData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
              AppSnackBar.showSuccess(context, '¡Cuenta creada! Inicia sesión.');
              provider.reset();
            });
          }

          if (provider.state is RegisterError) {
            final message = (provider.state as RegisterError).message;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.showError(context, message);
              provider.reset();
            });
          }

          return Column(
            children: [
              const RegisterHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 8),
                      Text(
                        'Crea tu cuenta de\nFastComp',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gratis para uno; planes de equipo si conectas tu tienda.',
                        style: TextStyle(color: Colors.black54, height: 1.5),
                      ),
                      SizedBox(height: 32),
                      RegisterForm(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
