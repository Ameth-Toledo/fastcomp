import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductsAppBar extends StatefulWidget {
  const ProductsAppBar({super.key});

  @override
  State<ProductsAppBar> createState() => _ProductsAppBarState();
}

class _ProductsAppBarState extends State<ProductsAppBar> {
  bool _searching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _stopSearch() {
    setState(() => _searching = false);
    _searchController.clear();
    context.read<ProductsProvider>().setSearchQuery('');
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFFEAE9E1),
      surfaceTintColor: const Color(0xFFEAE9E1),
      floating: true,
      snap: true,
      elevation: 0,
      titleSpacing: 24,
      automaticallyImplyLeading: false,
      title: _searching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: (v) => context.read<ProductsProvider>().setSearchQuery(v),
              decoration: const InputDecoration(
                hintText: 'Buscar producto o marca...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black38),
              ),
              style: const TextStyle(fontSize: 15),
            )
          : Row(
              children: [
                Image.asset('assets/img/logo.png', height: 28),
                const SizedBox(width: 8),
                const Text(
                  'FastComp',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
      actions: [
        _searching
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _stopSearch,
              )
            : IconButton(
                icon: const Icon(Icons.search, size: 24),
                onPressed: () => setState(() => _searching = true),
              ),
        const SizedBox(width: 4),
      ],
    );
  }
}
