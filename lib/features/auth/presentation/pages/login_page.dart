import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../shared/components/app_snackbar.dart';
import '../components/login_form.dart';
import '../components/login_header.dart';
import '../components/social_login_section.dart';
import '../pages/UiState/login_ui_state.dart';
import '../providers/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, provider, _) {
          if (provider.state is LoginData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, AppRoutes.products);
              provider.reset();
            });
          }

          if (provider.state is LoginError) {
            final message = (provider.state as LoginError).message;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.showError(context, message);
              provider.reset();
            });
          }

          return Column(
            children: [
              const LoginHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Bienvenido de vuelta',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Accede para gestionar tu inventario, ajustar stock y revisar productos destacados.',
                        style: TextStyle(color: Colors.black54, height: 1.5),
                      ),
                      const SizedBox(height: 32),
                      const LoginForm(),
                      const SizedBox(height: 32),
                      const SocialLoginSection(),
                      const SizedBox(height: 32),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('¿No tienes cuenta? ', style: TextStyle(fontSize: 13)),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                              child: const Text(
                                'REGÍSTRATE',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
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
