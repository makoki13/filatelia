// lib/utils/image_converter.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

class ImageConverter {
  // Para imágenes desde assets (durante desarrollo)
  static Future<String> assetToBase64(String assetPath) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final List<int> bytes = data.buffer.asUint8List();
      return base64Encode(bytes);
    } catch (e) {
      print('Error converting image: $e');
      return '';
    }
  }

  // Para imágenes desde archivo (Windows)
  static Future<String> fileToBase64(String filePath) async {
    try {
      final file = File(filePath);
      final List<int> bytes = await file.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      print('Error converting image: $e');
      return '';
    }
  }

  // Optimizar imagen antes de convertir (recomendado)
  static Future<String> optimizedAssetToBase64(
    String assetPath, {
    int maxWidth = 400,
    int maxHeight = 500,
  }) async {
    // Nota: Para optimización real necesitarías el paquete image: ^4.0.0
    // Esto es un placeholder para la lógica
    return await assetToBase64(assetPath);
  }
}