import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget principal que simula un libro de lujo para el álbum de sellos.
///
/// ✅ CORREGIDO: Estructura simplificada para no bloquear gestos
class LuxuryBook extends StatelessWidget {
  final Widget child;
  final String title;
  final String? subtitle;
  final Color coverColor;
  final Color goldColor;
  final double? maxWidth;

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
    // 🔍 DEBUG: Verificar que LuxuryBook se construye
    print('📚 LUXURY BOOK BUILD() EJECUTADO');

    return Container(
      constraints: maxWidth != null
          ? BoxConstraints(maxWidth: maxWidth!)
          : null,
      // 🔍 DEBUG: Listener para detectar clicks en cualquier parte del libro
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          print('🖱️ LuxuryBook: PointerDown en ${event.localPosition}');
        },
        onPointerUp: (event) {
          print('🖱️ LuxuryBook: PointerUp');
        },
        child: _buildBookContent(context),
      ),
    );
  }

  /// Construye el contenido completo del libro
  Widget _buildBookContent(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        // ✅ Color explícito para detectar gestos
        color: coverColor,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.5),
        child: Column(
          children: [
            _buildBookSpine(context),
            Expanded(child: _buildBookPages(context)),
          ],
        ),
      ),
    );
  }

  /// Construye el lomo del libro con título dorado
  Widget _buildBookSpine(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width > 600 ? 100 : 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            goldColor,
            goldColor.withValues(alpha: 0.8),
            goldColor.withValues(alpha: 0.6),
          ],
        ),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF8B6914), width: 2),
        ),
      ),
      // 🔍 DEBUG: Listener en el spine también
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          print('🖱️ BookSpine: PointerDown');
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.cinzel(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 32 : 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4A3420),
                  letterSpacing: 2,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 16 : 12,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF4A3420),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Construye las páginas del libro con efecto de papel antiguo
  Widget _buildBookPages(BuildContext context) {
    // 🔍 DEBUG: Verificar que se construyen las páginas
    print('📄 _buildBookPages() EJECUTADO');

    return Container(
      // ✅ Color de fondo EXPLÍCITO (crítico para gestos)
      color: const Color(0xFFFAF0E6),
      // ✅ Padding para que el contenido no toque los bordes
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // 🔍 DEBUG: Listener en el área de contenido principal
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.opaque,
                onPointerDown: (event) {
                  print('🖱️ BookPages: PointerDown en contenido');
                },
                child:
                    Container(), // Container invisible solo para detectar gestos
              ),
            ),

            // Contenido principal (ERA SCREEN, WELCOME PAGE, etc.)
            child,

            // Overlay decorativo sutil (sin bloquear gestos)
            Positioned.fill(
              child: IgnorePointer(
                // ✅ IgnorePointer para que no bloquee clicks
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.5,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                    ),
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
