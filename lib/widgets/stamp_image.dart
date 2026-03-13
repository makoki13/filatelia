import 'package:flutter/material.dart';
import 'dart:convert';

/// Widget para mostrar la imagen de un sello.
///
/// Maneja dos estados:
/// - Sello coleccionado: Muestra la imagen Base64
/// - Sello no coleccionado: Muestra un placeholder gris
class StampImage extends StatelessWidget {
  final String base64Data;
  final bool isCollected;
  final double width;
  final double height;

  /// ✅ CORREGIDO: Usar super.key en lugar de this.key
  const StampImage({
    super.key, // ✅ Sintaxis moderna Dart 2.17+
    required this.base64Data,
    required this.isCollected,
    this.width = 100,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: isCollected && base64Data.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(base64Data),
                fit: BoxFit.cover,
                width: width,
                height: height,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder();
                },
              ),
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(Icons.local_post_office, size: 40, color: Colors.grey[400]),
    );
  }
}
