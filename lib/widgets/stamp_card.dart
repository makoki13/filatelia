// lib/widgets/stamp_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 👈 Importar Provider
import '../models/stamp.dart';
import '../providers/album_provider.dart'; // 👈 Importar Provider
import '../models/stamp_rarity.dart';
import 'stamp_image.dart';

class StampCard extends StatelessWidget {
  final Stamp stamp;

  const StampCard({super.key, required this.stamp});

  @override
  Widget build(BuildContext context) {
    // ✅ Consultamos al Provider si este sello específico está en la colección
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    final isCollected = albumProvider.isStampCollected(stamp.id);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        // El color cambia según el estado devuelto por el Provider
        color: isCollected ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCollected ? stamp.rarity.color : Colors.grey[400]!,
          width: isCollected ? 2 : 1,
        ),
        // ... resto de la decoración
      ),
      child: Column(
        children: [
          // ... resto del widget
          Expanded(
            flex: 3,
            child: StampImage(
              base64Data: stamp.imageBase64,
              isCollected: isCollected, // 👈 Pasamos el estado real
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // ... información del sello
        ],
      ),
    );
  }
}
