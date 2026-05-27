import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEAE9E1),
      padding: const EdgeInsets.fromLTRB(24, 52, 24, 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/img/logo.png', height: 32),
              const SizedBox(width: 8),
              const Text('FastComp', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5, fontSize: 13)),
              const Spacer(),
              const Text('v0.1 · ES', style: TextStyle(color: Colors.black45, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 36),
          const Text(
            'INICIAR SESIÓN',
            style: TextStyle(fontSize: 11, letterSpacing: 2, color: Colors.black45),
          ),
          const SizedBox(height: 8),
          const Text(
            'Gestiona tu\ninventario.',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, height: 1.15),
          ),
        ],
      ),
    );
  }
}
