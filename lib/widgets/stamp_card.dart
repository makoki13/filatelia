// lib/widgets/stamp_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/stamp.dart';
import '../models/stamp_rarity.dart';
import '../providers/album_provider.dart';
import 'stamp_image.dart';

class StampCard extends StatelessWidget {
  final Stamp stamp;

  const StampCard({super.key, required this.stamp});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        final isCollected = albumProvider.isStampCollected(stamp.id);

        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCollected ? Colors.white : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isCollected ? stamp.rarity.color : Colors.grey[400]!,
              width: isCollected ? 2 : 1,
            ),
            boxShadow: isCollected
                ? [
                    BoxShadow(
                      color: stamp.rarity.backgroundColor,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              // ═══════════════════════════════════════════════════════════════
              // INDICADOR DE RAREZA (Parte superior)
              // ═══════════════════════════════════════════════════════════════
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: stamp.rarity.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      stamp.rarity.icon,
                      size: 12,
                      color: stamp.rarity.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      stamp.rarity.code,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: stamp.rarity.color,
                      ),
                    ),
                  ],
                ),
              ),

              // ═══════════════════════════════════════════════════════════════
              // IMAGEN DEL SELLO (Centro)
              // ═══════════════════════════════════════════════════════════════
              Expanded(
                flex: 3,
                child: StampImage(
                  base64Data: stamp.imageBase64,
                  isCollected: isCollected,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // ═══════════════════════════════════════════════════════════════
              // PIE DE PÁGINA (2 filas: Name + Value)
              // ═══════════════════════════════════════════════════════════════
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ✅ FILA 1: Nombre del sello
                      Text(
                        stamp.name,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isCollected
                              ? Colors.black87
                              : Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // ✅ FILA 2: Valor en pesetas
                      Text(
                        '${stamp.valuePesetas} Ptas',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 11,
                          color: isCollected
                              ? const Color(0xFF8B4513)
                              : Colors.grey[500],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
