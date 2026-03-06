import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/album_provider.dart';
import '../data/stamp_database.dart';
import '../models/era.dart';

/// Panel lateral de navegación que muestra todas las épocas del álbum.
/// 
/// Este widget permite al usuario:
/// - Ver todas las épocas históricas disponibles
/// - Consultar el progreso de colección de cada época
/// - Navegar directamente a una época específica
/// 
/// Diseñado para integrarse con LuxuryBook en el lado izquierdo.
class EraNavigation extends StatelessWidget {
  /// Callback que se ejecuta cuando el usuario selecciona una época
  final Function(String eraId) onEraSelected;

  /// ID de la época actualmente seleccionada (para resaltado visual)
  final String? selectedEraId;

  /// Ancho del panel de navegación
  final double width;

  /// Constructor principal
  const EraNavigation({
    super.key,
    required this.onEraSelected,
    this.selectedEraId,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        if (albumProvider.isLoading) {
          return _buildLoadingState();
        }

        return _buildNavigationPanel(context, albumProvider);
      },
    );
  }

  /// Construye el panel de navegación principal
  Widget _buildNavigationPanel(BuildContext context, AlbumProvider provider) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        // Fondo oscuro elegante para contraste con las páginas
        color: const Color(0xFF2C1810),
        border: Border(
          right: BorderSide(
            color: const Color(0xFFD4AF37),
            width: 3,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // ═══════════════════════════════════════════════════════════════
          // CABECERA DEL PANEL
          // ═══════════════════════════════════════════════════════════════
          _buildHeader(context, provider),

          // ═══════════════════════════════════════════════════════════════
          // LISTA DE ÉPOCAS
          // ═══════════════════════════════════════════════════════════════
          Expanded(
            child: _buildErasList(context, provider),
          ),

          // ═══════════════════════════════════════════════════════════════
          // PIE DE PANEL (Progreso global)
          // ═══════════════════════════════════════════════════════════════
          _buildFooter(context, provider),
        ],
      ),
    );
  }

  /// Construye la cabecera del panel con título
  Widget _buildHeader(BuildContext context, AlbumProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Fondo dorado para la cabecera
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFD4AF37),
            const Color(0xFFB8941F),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF8B6914),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          // Icono decorativo
          Icon(
            Icons.auto_stories,
            size: 40,
            color: const Color(0xFF2C1810),
          ),
          const SizedBox(height: 8),
          // Título
          Text(
            'ÉPOCAS',
            style: GoogleFonts.cinzel(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1810),
              letterSpacing: 3,
              shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.5),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Subtítulo con número total de épocas
          Text(
            '${StampDatabase.eras.length} Períodos Históricos',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 12,
              color: const Color(0xFF2C1810),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye la lista scrollable de épocas
  Widget _buildErasList(BuildContext context, AlbumProvider provider) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: StampDatabase.eras.length,
      itemBuilder: (context, index) {
        final era = StampDatabase.eras[index];
        final progress = provider.getProgressPercentage(era.id);
        final isSelected = selectedEraId == era.id;

        return _buildEraItem(era, progress, isSelected, provider);
      },
    );
  }

  /// Construye un item individual de época
  Widget _buildEraItem(
    Era era,
    int progress,
    bool isSelected,
    AlbumProvider provider,
  ) {
    final collectedStamps = era.countCollectedStamps(provider.collectedStampIds);
    final totalStamps = era.totalStamps;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onEraSelected(era.id),
        hoverColor: const Color(0xFFD4AF37).withOpacity(0.2),
        splashColor: const Color(0xFFD4AF37).withOpacity(0.3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            // Fondo diferente si está seleccionado
            color: isSelected
                ? const Color(0xFF4A3420)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected
                    ? const Color(0xFFD4AF37)
                    : Colors.transparent,
                width: 4,
              ),
              bottom: BorderSide(
                color: const Color(0xFFD4AF37).withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título de la época
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      era.title,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? const Color(0xFFD4AF37)
                            : Colors.white,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Icono de estado (completado o pendiente)
                  if (progress == 100 && totalStamps > 0)
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: const Color(0xFFD4AF37),
                    ),
                ],
              ),

              const SizedBox(height: 4),

              // Período de años
              Text(
                '${era.startYear} - ${era.endYear}',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 12,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 10),

              // Barra de progreso
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getProgressColor(progress),
                  ),
                  minHeight: 6,
                ),
              ),

              const SizedBox(height: 6),

              // Texto de progreso (ej: "3 de 15 sellos")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$collectedStamps / $totalStamps sellos',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 11,
                      color: const Color(0xFFD4AF37),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$progress%',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 11,
                      color: const Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye el pie de panel con progreso global
  Widget _buildFooter(BuildContext context, AlbumProvider provider) {
    final totalStamps = StampDatabase.totalStampsCount;
    final collectedCount = provider.collectedCount;
    final globalProgress = totalStamps > 0
        ? ((collectedCount / totalStamps) * 100).round()
        : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0F0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFD4AF37),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          // Título de progreso global
          Text(
            'PROGRESO GLOBAL',
            style: GoogleFonts.cinzel(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4AF37),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          // Barra de progreso global
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: globalProgress / 100,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          // Texto de progreso global
          Text(
            '$collectedCount de $totalStamps sellos coleccionados',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 11,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            '$globalProgress% completado',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 14,
              color: const Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye estado de carga
  Widget _buildLoadingState() {
    return Container(
      width: width,
      color: const Color(0xFF2C1810),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
            ),
            SizedBox(height: 16),
            Text(
              'Cargando álbum...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Obtiene el color de la barra de progreso según el porcentaje
  Color _getProgressColor(int progress) {
    if (progress == 100) {
      return const Color(0xFF4CAF50); // Verde para completado
    } else if (progress >= 50) {
      return const Color(0xFFD4AF37); // Dorado para medio
    } else {
      return const Color(0xFF8B7355); // Bronce para inicio
    }
  }
}