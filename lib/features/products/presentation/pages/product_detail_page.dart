import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../shared/components/app_snackbar.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_condition.dart';
import '../providers/add_product_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Product _product;
  bool _modified = false;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  Future<void> _onEdit() async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.editProduct,
      arguments: _product,
    );
    if (result is Product && mounted) {
      setState(() {
        _product = result;
        _modified = true;
      });
    }
  }

  Future<void> _onDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _DeleteDialog(productName: _product.name),
    );
    if (confirmed != true || !mounted) return;

    try {
      await context.read<AddProductProvider>().deleteProduct(_product.id);
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      AppSnackBar.showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop && _modified) {
          // result already popped; caller must await pushNamed to get true
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _AppBar(product: _product, onEdit: _onEdit, onDelete: _onDelete, onBack: () {
              Navigator.pop(context, _modified);
            }),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductImage(product: _product),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _product.brand.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 11, letterSpacing: 1.5, color: Colors.black45),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _product.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _Label('PRECIO'),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${_product.price % 1 == 0 ? _product.price.toInt() : _product.price}',
                                    style: const TextStyle(
                                        fontSize: 28, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const _Label('CONDICIÓN'),
                                  const SizedBox(height: 4),
                                  Text(
                                    _conditionLabel(_product.condition),
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(height: 1, color: Colors.black12),
                          const SizedBox(height: 20),
                          _StockSection(stock: _product.stock),
                          if (_product.description != null &&
                              _product.description!.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            Text(
                              _product.description!,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87, height: 1.6),
                            ),
                          ],
                          if (_product.specs.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            const _Label('FICHA TÉCNICA'),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _product.specs
                                  .map((s) => _SpecChip(label: s))
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _conditionLabel(ProductCondition condition) => switch (condition) {
        ProductCondition.nuevo => 'Nuevo',
        ProductCondition.reacondicionado => 'Reacond.',
        ProductCondition.segunda_mano => '2ª Mano',
      };
}

class _AppBar extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onBack;

  const _AppBar({
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onBack,
  });

  String _categoryAbbrev(ProductCategory c) => switch (c) {
        ProductCategory.audio => 'AUD',
        ProductCategory.computacion => 'CMP',
        ProductCategory.movil => 'MOV',
        ProductCategory.smarthome => 'SHM',
        ProductCategory.fotografia => 'FOT',
        ProductCategory.accesorios => 'ACC',
      };

  @override
  Widget build(BuildContext context) {
    final abbrev = _categoryAbbrev(product.category);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 28),
            onPressed: onBack,
          ),
          Expanded(
            child: Text(
              '$abbrev · ${product.brand.toUpperCase()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ),
          TextButton(
            onPressed: onEdit,
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            child: const Text(
              'EDITAR',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 12),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 22),
            color: Colors.red,
            onPressed: onDelete,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final Product product;
  const _ProductImage({required this.product});

  Color _categoryColor(ProductCategory c) => switch (c) {
        ProductCategory.audio => const Color(0xFFB8D8F8),
        ProductCategory.computacion => const Color(0xFFCFC8F0),
        ProductCategory.movil => const Color(0xFFF0C8C8),
        ProductCategory.smarthome => const Color(0xFFF0DEB8),
        ProductCategory.fotografia => const Color(0xFFF0F0B8),
        ProductCategory.accesorios => const Color(0xFFDDDDDD),
      };

  String _categoryAbbrev(ProductCategory c) => switch (c) {
        ProductCategory.audio => 'AUD',
        ProductCategory.computacion => 'CMP',
        ProductCategory.movil => 'MOV',
        ProductCategory.smarthome => 'SHM',
        ProductCategory.fotografia => 'FOT',
        ProductCategory.accesorios => 'ACC',
      };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bg = _categoryColor(product.category);
    final abbrev = _categoryAbbrev(product.category);
    final brandAbbrev =
        product.brand.substring(0, product.brand.length.clamp(0, 3)).toUpperCase();

    if (product.imageUrl != null) {
      return SizedBox(
        width: width,
        height: 240,
        child: Image.network(
          product.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => _fallback(width, bg, abbrev, brandAbbrev),
        ),
      );
    }
    return _fallback(width, bg, abbrev, brandAbbrev);
  }

  Widget _fallback(double width, Color bg, String abbrev, String brandAbbrev) {
    return SizedBox(
      width: width,
      height: 240,
      child: Stack(
        children: [
          Container(color: bg),
          CustomPaint(size: Size(width, 240), painter: _HatchPainter()),
          const Center(
            child: Text(
              'FOTO DEL PRODUCTO',
              style: TextStyle(
                  fontSize: 11, letterSpacing: 2, color: Colors.black38),
            ),
          ),
          Positioned(
            top: 12,
            left: 16,
            child: Text(abbrev,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
          ),
          Positioned(
            bottom: 12,
            right: 16,
            child: Text(brandAbbrev,
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..strokeWidth = 1.5;
    const step = 14.0;
    for (double i = -size.height; i < size.width; i += step) {
      canvas.drawLine(Offset(i, size.height), Offset(i + size.height, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _StockSection extends StatelessWidget {
  final int stock;
  const _StockSection({required this.stock});

  @override
  Widget build(BuildContext context) {
    final fraction = (stock / 50).clamp(0.0, 1.0);
    final (statusText, statusColor) = stock == 0
        ? ('AGOTADO', Colors.red)
        : stock <= 5
            ? ('STOCK BAJO', Colors.orange)
            : ('DISPONIBLE', const Color(0xFF4CAF50));

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Label('EXISTENCIAS'),
                  const SizedBox(height: 4),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
            _StepButton(icon: Icons.remove),
            const SizedBox(width: 12),
            Text(
              '$stock',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            _StepButton(icon: Icons.add),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 4,
            backgroundColor: Colors.black12,
            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$stock',
            style: const TextStyle(fontSize: 10, color: Colors.black38),
          ),
        ),
      ],
    );

    if (stock <= 5) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: statusColor.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: content,
      );
    }

    return content;
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  const _StepButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(icon, size: 16),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String label;
  const _SpecChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 12, color: Colors.black87)),
    );
  }
}

class _DeleteDialog extends StatelessWidget {
  final String productName;
  const _DeleteDialog({required this.productName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      title: const Text(
        'Eliminar producto',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Text(
        '¿Estás seguro de que quieres eliminar "$productName"? Esta acción no se puede deshacer.',
        style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: TextButton.styleFrom(foregroundColor: Colors.black54),
          child: const Text('CANCELAR'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('ELIMINAR', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 10, letterSpacing: 1.5, color: Colors.black45),
    );
  }
}
