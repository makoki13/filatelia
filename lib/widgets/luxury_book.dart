import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget principal que simula un libro de lujo para el álbum de sellos.
/// 
/// Este widget crea un contenedor con apariencia de libro antiguo,
/// incluyendo tapas con textura, lomo dorado y páginas con efecto de papel.
/// 
/// Diseñado para ser responsive en Windows (escritorio) y dispositivos móviles.
class LuxuryBook extends StatelessWidget {
  /// Contenido principal que se mostrará dentro del libro (páginas)
  final Widget child;

  /// Título principal que aparece en el lomo del libro
  final String title;

  /// Subtítulo opcional que aparece debajo del título
  final String? subtitle;

  /// Color principal de la tapa del libro (por defecto: marrón cuero)
  final Color coverColor;

  /// Color de los detalles dorados del libro
  final Color goldColor;

  /// Ancho máximo del libro (útil para escritorio)
  final double? maxWidth;

  /// Constructor principal
  const LuxuryBook({
    super.key,
    required this.child,
    this.title = 'Álbum de Sellos',
    this.subtitle,
    this.coverColor = const Color(0xFF8B4513),
    this.goldColor = const Color(0xFFD4AF37),
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth!) : null,
      decoration: BoxDecoration(
        // Gradiente que simula textura de cuero envejecido
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            coverColor,
            coverColor.withOpacity(0.8),
            coverColor.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          // Sombra exterior para efecto de profundidad
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          // Sombra interior para efecto de relieve
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: -5,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // ═══════════════════════════════════════════════════════════════
          // LOMO DEL LIBRO (Parte superior)
          // ═══════════════════════════════════════════════════════════════
          _buildBookSpine(context),

          // ═══════════════════════════════════════════════════════════════
          // PÁGINAS DEL LIBRO (Contenido principal)
          // ═══════════════════════════════════════════════════════════════
          Expanded(
            child: _buildBookPages(context),
          ),
        ],
      ),
    );
  }

  /// Construye el lomo del libro con título dorado
  Widget _buildBookSpine(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width > 600 ? 100 : 70,
      decoration: BoxDecoration(
        // Gradiente dorado para el lomo
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            goldColor,
            goldColor.withOpacity(0.8),
            goldColor.withOpacity(0.6),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(color: goldColor.withOpacity(0.5), width: 2),
          left: BorderSide(color: Colors.black.withOpacity(0.3), width: 1),
          right: BorderSide(color: Colors.black.withOpacity(0.3), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título principal con fuente elegante
            Text(
              title,
              style: GoogleFonts.cinzel(
                fontSize: MediaQuery.of(context).size.width > 600 ? 32 : 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A3420),
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
            // Subtítulo opcional
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 12,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF4A3420),
                  letterSpacing: 1,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Construye las páginas del libro con efecto de papel antiguo
  Widget _buildBookPages(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Color crema para simular papel envejecido
        color: const Color(0xFFFAF0E6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD4AF37).withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          // Sombra interior para efecto de profundidad de página
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            // Contenido principal
            child,

            // Overlay de textura de papel (opcional, sutil)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.5,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}