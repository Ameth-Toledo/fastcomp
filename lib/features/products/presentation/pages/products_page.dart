import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../shared/components/app_snackbar.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../components/product_category_section.dart';
import '../components/products_app_bar.dart';
import '../components/products_empty_state.dart';
import '../components/products_header.dart';
import '../providers/products_provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsProvider>().fetchProducts();
    });
  }

  Map<ProductCategory, List<Product>> _groupByCategory(List<Product> products) {
    final map = <ProductCategory, List<Product>>{};
    for (final product in products) {
      map.putIfAbsent(product.category, () => []).add(product);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      floatingActionButton: Consumer<ProductsProvider>(
        builder: (context, provider, _) {
          if (provider.products.isEmpty) return const SizedBox.shrink();
          return FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: const Color(0xFFC8F135),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            onPressed: () async {
              final created = await Navigator.pushNamed(context, AppRoutes.addProduct);
              if (created == true && context.mounted) {
                provider.fetchProducts();
                AppSnackBar.showSuccess(context, 'Producto agregado correctamente.');
              }
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: provider.fetchProducts,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final grouped = _groupByCategory(provider.products);

          return CustomScrollView(
            slivers: [
              const ProductsAppBar(),
              SliverToBoxAdapter(
                child: ProductsHeader(products: provider.products),
              ),
              if (provider.products.isEmpty)
                const SliverToBoxAdapter(child: ProductsEmptyState())
              else
                for (final entry in grouped.entries)
                  SliverToBoxAdapter(
                    child: ProductCategorySection(
                      category: entry.key,
                      products: entry.value,
                    ),
                  ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
            ],
          );
        },
      ),
    );
  }
}
