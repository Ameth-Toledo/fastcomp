import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final void Function(Uint8List bytes, String filename) onImageSelected;
  final Uint8List? imageBytes;

  const ImagePickerField({
    super.key,
    required this.onImageSelected,
    this.imageBytes,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final _picker = ImagePicker();

  Future<void> _pick() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    widget.onImageSelected(bytes, file.name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pick,
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4),
        ),
        child: widget.imageBytes != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.memory(widget.imageBytes!, fit: BoxFit.cover),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_outlined, size: 28, color: Colors.black26),
                  SizedBox(height: 8),
                  Text(
                    'ARRASTRA UNA IMAGEN',
                    style: TextStyle(fontSize: 11, letterSpacing: 1.5, color: Colors.black38),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'JPG/PNG · MÍN. 800×800',
                    style: TextStyle(fontSize: 10, color: Colors.black26),
                  ),
                ],
              ),
      ),
    );
  }
}
