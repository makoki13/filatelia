import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget principal que simula un libro de lujo para el álbum de sellos.
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
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth!) : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            coverColor,
            coverColor.withValues(alpha: 0.8),
            coverColor.withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: -5,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBookSpine(context),
          Expanded(child: _buildBookPages(context)),
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            goldColor,
            goldColor.withValues(alpha: 0.8),
            goldColor.withValues(alpha: 0.6),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(color: goldColor.withValues(alpha: 0.5), width: 2),
          left: BorderSide(color: Colors.black.withValues(alpha: 0.3), width: 1),
          right: BorderSide(color: Colors.black.withValues(alpha: 0.3), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
                shadows: [
                  Shadow(
                    color: Colors.white.withValues(alpha: 0.5),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
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
        color: const Color(0xFFFAF0E6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
            child,
            Positioned.fill(
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
          ],
        ),
      ),
    );
  }
}