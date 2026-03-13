import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/album_provider.dart';
import '../data/stamp_database.dart';
import '../models/era.dart';

/// Panel lateral de navegación que muestra todas las épocas del álbum.
class EraNavigation extends StatelessWidget {
  final Function(String eraId) onEraSelected;
  final String? selectedEraId;
  final double width;
  final VoidCallback? onHeaderTap;

  const EraNavigation({
    super.key,
    required this.onEraSelected,
    this.selectedEraId,
    this.width = 280,
    this.onHeaderTap,
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
        color: const Color(0xFF2C1810),
        border: Border(
          right: BorderSide(color: const Color(0xFFD4AF37), width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(5, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context, provider),
          Expanded(child: _buildErasList(context, provider)),
          _buildFooter(context, provider),
        ],
      ),
    );
  }

  /// Construye la cabecera del panel con título
  Widget _buildHeader(BuildContext context, AlbumProvider provider) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onHeaderTap,
        hoverColor: const Color(0xFFD4AF37).withValues(alpha: 0.3),
        splashColor: const Color(0xFFD4AF37).withValues(alpha: 0.4),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFFD4AF37), const Color(0xFFB8941F)],
            ),
            border: Border(
              bottom: BorderSide(color: const Color(0xFF8B6914), width: 2),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.auto_stories,
                size: 40,
                color: const Color(0xFF2C1810),
              ),
              const SizedBox(height: 8),
              Text(
                'ÉPOCAS',
                style: GoogleFonts.cinzel(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1810),
                  letterSpacing: 3,
                  shadows: [
                    Shadow(
                      color: Colors.white.withValues(alpha: 0.5),
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${StampDatabase.eras.length} Períodos Históricos',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 12,
                  color: const Color(0xFF2C1810),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (onHeaderTap != null) ...[
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      size: 14,
                      color: const Color(0xFF2C1810).withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Volver al inicio',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 11,
                        color: const Color(0xFF2C1810).withValues(alpha: 0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
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
    final collectedStamps = era.countCollectedStamps(
      provider.collectedStampIds,
    );
    final totalStamps = era.totalStamps;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onEraSelected(era.id),
        hoverColor: const Color(0xFFD4AF37).withValues(alpha: 0.2),
        splashColor: const Color(0xFFD4AF37).withValues(alpha: 0.3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4A3420) : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected
                    ? const Color(0xFFD4AF37)
                    : Colors.transparent,
                width: 4,
              ),
              bottom: BorderSide(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  if (progress == 100 && totalStamps > 0)
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: const Color(0xFFD4AF37),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${era.startYear} - ${era.endYear}',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.white.withValues(alpha: 0.24),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getProgressColor(progress),
                  ),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 6),
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
          top: BorderSide(color: const Color(0xFFD4AF37), width: 2),
        ),
      ),
      child: Column(
        children: [
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
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: globalProgress / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.24),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFD4AF37),
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$collectedCount de $totalStamps sellos coleccionados',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.7),
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
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// Obtiene el color de la barra de progreso según el porcentaje
  Color _getProgressColor(int progress) {
    if (progress == 100) {
      return const Color(0xFF4CAF50);
    } else if (progress >= 50) {
      return const Color(0xFFD4AF37);
    } else {
      return const Color(0xFF8B7355);
    }
  }
}
