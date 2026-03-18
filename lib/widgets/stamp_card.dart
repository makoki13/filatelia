import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/stamp.dart';
import '../models/stamp_rarity.dart';
import '../providers/album_provider.dart';
import 'stamp_image.dart';

/// Tarjeta individual de sello coleccionable.
///
/// Muestra:
/// - Indicador de rareza (parte superior)
/// - Imagen del sello (centro)
/// - Nombre y descripción (pie de página - 2 filas)
class StampCard extends StatelessWidget {
  final Stamp stamp;

  const StampCard({super.key, required this.stamp});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        final isCollected = albumProvider.isStampCollected(stamp.id);

        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isCollected ? Colors.white : const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isCollected ? stamp.rarity.color : const Color(0xFFB0B0B0),
              width: isCollected ? 2 : 1,
            ),
            boxShadow: isCollected
                ? [
                    BoxShadow(
                      color: stamp.rarity.backgroundColor,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
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
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: stamp.rarity.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      stamp.rarity.icon,
                      size: 10,
                      color: stamp.rarity.color,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      stamp.rarity.code,
                      style: TextStyle(
                        fontSize: 12,
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
                flex: 10,
                child: StampImage(
                  base64Data: stamp.imageBase64,
                  isCollected: isCollected,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // ═══════════════════════════════════════════════════════════════
              // PIE DE PÁGINA (2 filas: Name + Description)
              // ═══════════════════════════════════════════════════════════════
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ✅ FILA 1: Nombre del sello
                      Text(
                        stamp.name,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isCollected
                              ? const Color(0xFF2C1810)
                              : const Color(0xFF888888),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 2),

                      // ✅ FILA 2: Descripción del sello (CAMBIO SOLICITADO)
                      Text(
                        stamp.description,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 12, // ✅ Fuente más pequeña para descripción
                          color: isCollected
                              ? const Color(0xFF8B4513)
                              : const Color(0xFFAAAAAA),
                          fontStyle:
                              FontStyle.italic, // ✅ Cursiva para descripción
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2, // ✅ Máximo 2 líneas para descripción
                        overflow: TextOverflow.ellipsis,
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
