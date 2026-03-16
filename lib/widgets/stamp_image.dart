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

  const StampImage({
    super.key,
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
      //child: isCollected && base64Data.isNotEmpty
      child: base64Data.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildImageFromBase64(),
            )
          : _buildPlaceholder(),
    );
  }

  /// ✅ Construye la imagen desde Base64 (maneja prefijo data URI)
  Widget _buildImageFromBase64() {
    try {
      // ✅ Eliminar prefijo 'data:image/jpeg;base64,' si existe
      String cleanBase64 = base64Data;
      if (base64Data.contains(',')) {
        cleanBase64 = base64Data.split(',').last;
      }

      // ✅ Decodificar Base64 a bytes
      final bytes = base64Decode(cleanBase64);

      // ✅ Crear imagen desde memoria
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          print('❌ Error cargando imagen: $error');
          return _buildPlaceholder();
        },
      );
    } catch (e) {
      print('❌ Excepción decodificando Base64: $e');
      return _buildPlaceholder();
    }
  }

  /// Construye placeholder cuando no hay imagen
  Widget _buildPlaceholder() {
    return Center(
      child: Icon(Icons.local_post_office, size: 40, color: Colors.grey[400]),
    );
  }
}
