import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../shared/components/app_snackbar.dart';
import '../providers/products_provider.dart';

class ProductsEmptyState extends StatelessWidget {
  const ProductsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            color: const Color(0xFFC8F135),
            child: const Icon(Icons.add, size: 28, color: Colors.black),
          ),
          const SizedBox(height: 20),
          const Text(
            'Sin productos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Empieza añadiendo tu primer producto. Podrás registrar marca, precio, stock y la ficha técnica completa.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black45, height: 1.5),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                final created = await Navigator.pushNamed(context, AppRoutes.addProduct);
                if (created == true && context.mounted) {
                  context.read<ProductsProvider>().fetchProducts();
                  AppSnackBar.showSuccess(context, 'Producto agregado correctamente.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text(
                'AÑADIR PRIMERO',
                style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
