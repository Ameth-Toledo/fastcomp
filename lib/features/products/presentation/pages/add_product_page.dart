import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../shared/components/app_snackbar.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_condition.dart';
import '../components/category_selector.dart';
import '../components/condition_selector.dart';
import '../components/image_picker_field.dart';
import '../components/stock_stepper.dart';
import '../pages/UiState/add_product_ui_state.dart';
import '../providers/add_product_provider.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;

  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _brandController = TextEditingController();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  late ProductCategory _category;
  late ProductCondition _condition;
  late int _stock;
  late bool _featured;
  Uint8List? _imageBytes;
  String? _imageFilename;

  bool get _isEditMode => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    if (p != null) {
      _brandController.text = p.brand;
      _nameController.text = p.name;
      _modelController.text = '';
      _priceController.text = p.price % 1 == 0
          ? p.price.toInt().toString()
          : p.price.toString();
      _descriptionController.text = p.description ?? '';
      _category = p.category;
      _condition = p.condition;
      _stock = p.stock;
      _featured = p.featured;
    } else {
      _category = ProductCategory.audio;
      _condition = ProductCondition.nuevo;
      _stock = 1;
      _featured = false;
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _nameController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _brandController.text.trim().isNotEmpty &&
      _nameController.text.trim().isNotEmpty &&
      (_isEditMode || _modelController.text.trim().isNotEmpty) &&
      (_priceController.text.trim().isNotEmpty &&
          double.tryParse(_priceController.text.trim()) != null &&
          double.parse(_priceController.text.trim()) > 0);

  String get _composedName {
    final name = _nameController.text.trim();
    final model = _modelController.text.trim();
    return model.isEmpty ? name : '$name $model';
  }

  void _submit() {
    final provider = context.read<AddProductProvider>();
    if (_isEditMode) {
      provider.updateProduct(
        id: widget.product!.id,
        brand: _brandController.text.trim(),
        name: _composedName,
        category: _category.name,
        price: double.parse(_priceController.text.trim()),
        stock: _stock,
        condition: _condition.name,
        featured: _featured,
        description: _descriptionController.text.trim(),
        imageBytes: _imageBytes,
        imageFilename: _imageFilename,
      );
    } else {
      provider.createProduct(
        brand: _brandController.text.trim(),
        name: _composedName,
        category: _category.name,
        price: double.parse(_priceController.text.trim()),
        stock: _stock,
        condition: _condition.name,
        featured: _featured,
        description: _descriptionController.text.trim(),
        imageBytes: _imageBytes,
        imageFilename: _imageFilename,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: Consumer<AddProductProvider>(
        builder: (context, provider, _) {
          if (provider.state is AddProductSuccess) {
            final updated = (provider.state as AddProductSuccess).product;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context, _isEditMode ? updated : true);
              provider.reset();
            });
          }

          if (provider.state is AddProductError) {
            final msg = (provider.state as AddProductError).message;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppSnackBar.showError(context, msg);
              provider.reset();
            });
          }

          final isLoading = provider.state is AddProductLoading;

          return Column(
            children: [
              _AppBar(
                isEditMode: _isEditMode,
                isLoading: isLoading,
                canSave: _isFormValid && !isLoading,
                onSave: _submit,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImagePickerField(
                        imageBytes: _imageBytes,
                        initialImageUrl: widget.product?.imageUrl,
                        onImageSelected: (bytes, name) => setState(() {
                          _imageBytes = bytes;
                          _imageFilename = name;
                        }),
                      ),
                      const SizedBox(height: 20),
                      const _Label('MARCA'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _brandController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Sony, Apple, Logitech...',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const _Label('NOMBRE'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _nameController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Audífonos, Laptop, Monitor...',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      if (!_isEditMode) ...[
                        const SizedBox(height: 20),
                        const _Label('MODELO'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _modelController,
                          onChanged: (_) => setState(() {}),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: 'WH-1000XM5, iPhone 15 Pro...',
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      const _Label('CATEGORÍA'),
                      const SizedBox(height: 10),
                      CategorySelector(
                        selected: _category,
                        onSelected: (cat) => setState(() => _category = cat),
                      ),
                      const SizedBox(height: 20),
                      const _Label('PRECIO'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _priceController,
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true),
                        onChanged: (_) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
                        ],
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          hintText: '0',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const _Label('STOCK'),
                          const SizedBox(width: 8),
                          Text(
                            '· $_stock',
                            style: const TextStyle(
                                fontSize: 11, color: Colors.black45),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      StockStepper(
                        value: _stock,
                        onChanged: (v) => setState(() => _stock = v),
                      ),
                      const SizedBox(height: 20),
                      const _Label('CONDICIÓN'),
                      const SizedBox(height: 10),
                      ConditionSelector(
                        selected: _condition,
                        onSelected: (cond) => setState(() => _condition = cond),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const _Label('DESTACADO'),
                          Switch(
                            value: _featured,
                            activeThumbColor: const Color(0xFFC8F135),
                            activeTrackColor: Colors.black,
                            onChanged: (v) => setState(() => _featured = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const _Label('DESCRIPCIÓN · OPCIONAL'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Características relevantes...',
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 32),
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

class _AppBar extends StatelessWidget {
  final bool isEditMode;
  final bool isLoading;
  final bool canSave;
  final VoidCallback onSave;

  const _AppBar({
    required this.isEditMode,
    required this.isLoading,
    required this.canSave,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              isEditMode ? 'EDITAR PRODUCTO' : 'NUEVO PRODUCTO',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : TextButton(
                    onPressed: canSave ? onSave : null,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      disabledForegroundColor: Colors.black26,
                    ),
                    child: const Text(
                      'GUARDAR',
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
          ),
        ],
      ),
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
      style: const TextStyle(fontSize: 11, letterSpacing: 1.5, color: Colors.black54),
    );
  }
}
