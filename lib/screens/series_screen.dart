import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/album_provider.dart';
import '../models/series.dart';
import '../widgets/stamp_card.dart';

/// Pantalla de detalle de una serie de sellos.
///
/// Muestra:
/// - Información de la serie (nombre, período, descripción)
/// - Progreso de colección de esta serie
/// - Grid de todos los sellos de la serie
/// - Cada sello muestra si está coleccionado o pendiente
///
/// Diseñada para ser responsive en Windows (escritorio) y dispositivos móviles.
class SeriesScreen extends StatelessWidget {
  /// Serie a mostrar
  final Series series;

  const SeriesScreen({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        // Calcular progreso de esta serie
        final totalStamps = series.stamps.length;
        final collectedStamps = series.countCollectedStamps(
          albumProvider.collectedStampIds,
        );
        final progress = series.getProgressPercentage(
          albumProvider.collectedStampIds,
        );
        final isComplete = progress == 100 && totalStamps > 0;

        // Detectar si es dispositivo móvil o escritorio
        final isMobile = MediaQuery.of(context).size.width < 800;
        final crossAxisCount = isMobile ? 3 : 5;

        return Scaffold(
          backgroundColor: const Color(0xFF1A0F0A),

          // ═══════════════════════════════════════════════════════════════
          // APP BAR PERSONALIZADA
          // ═══════════════════════════════════════════════════════════════
          appBar: AppBar(
            title: Text(
              series.name,
              style: GoogleFonts.cinzel(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD4AF37),
              ),
            ),
            backgroundColor: const Color(0xFF8B4513),
            foregroundColor: const Color(0xFFD4AF37),
            elevation: 2,
            actions: [
              // Indicador de progreso en AppBar
              if (totalStamps > 0)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isComplete
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFD4AF37),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '$progress%',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // ═══════════════════════════════════════════════════════════════
          // CUERPO DE LA PANTALLA
          // ═══════════════════════════════════════════════════════════════
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFAF0E6),
                  const Color(0xFFEDE0D4),
                  const Color(0xFFE6D5C3),
                ],
              ),
            ),
            child: Column(
              children: [
                // Información de la serie
                _buildSeriesInfo(
                  series,
                  progress,
                  collectedStamps,
                  totalStamps,
                  isComplete,
                ),

                // Separador
                _buildDivider(),

                // Grid de sellos
                Expanded(
                  child: _buildStampsGrid(
                    series,
                    albumProvider,
                    crossAxisCount,
                  ),
                ),
              ],
            ),
          ),

          // ═══════════════════════════════════════════════════════════════
          // FLOATING ACTION BUTTON (si está completa)
          // ═══════════════════════════════════════════════════════════════
          floatingActionButton: isComplete
              ? FloatingActionButton.extended(
                  onPressed: () => _showCompletionDialog(context),
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.emoji_events),
                  label: const Text('¡Completada!'),
                )
              : null,
        );
      },
    );
  }

  /// Construye la información de la serie
  Widget _buildSeriesInfo(
    Series series,
    int progress,
    int collectedStamps,
    int totalStamps,
    bool isComplete,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37).withOpacity(0.15),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD4AF37).withOpacity(0.5),
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título y período
          Row(
            children: [
              // Icono de estado
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isComplete
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFD4AF37),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isComplete ? Icons.check_circle : Icons.collections_bookmark,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Información principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      series.name,
                      style: GoogleFonts.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C1810),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${series.startYear} - ${series.endYear}',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 14,
                        color: Colors.brown[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Descripción
          if (series.description.isNotEmpty)
            Text(
              series.description,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: Colors.brown[800],
                height: 1.5,
              ),
            ),

          const SizedBox(height: 16),

          // Barra de progreso
          _buildProgressBar(progress, collectedStamps, totalStamps),
        ],
      ),
    );
  }

  /// Construye la barra de progreso
  Widget _buildProgressBar(int progress, int collectedStamps, int totalStamps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra visual
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: totalStamps > 0 ? progress / 100 : 0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(progress),
            ),
            minHeight: 8,
          ),
        ),

        const SizedBox(height: 8),

        // Texto de progreso
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$collectedStamps de $totalStamps sellos coleccionados',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 13,
                color: Colors.brown[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: _getProgressColor(progress),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$progress%',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Construye separador decorativo
  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFFD4AF37).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  /// Construye el grid de sellos
  Widget _buildStampsGrid(
    Series series,
    AlbumProvider provider,
    int crossAxisCount,
  ) {
    if (series.stamps.isEmpty) {
      return _buildEmptyStampsState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: series.stamps.length,
      itemBuilder: (context, index) {
        final stamp = series.stamps[index];
        return StampCard(stamp: stamp);
      },
    );
  }

  /// Construye estado vacío (sin sellos)
  Widget _buildEmptyStampsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_post_office, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              'Próximamente',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Los sellos de esta serie\nestarán disponibles pronto',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra dialog de completado
  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFAF0E6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFD4AF37), width: 2),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¡Serie Completada!',
              style: GoogleFonts.cinzel(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C1810),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Has coleccionado todos los sellos\nde "${series.name}"',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: Colors.brown[700],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Continuar',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B4513),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Obtiene el color según el progreso
  Color _getProgressColor(int progress) {
    if (progress == 100) {
      return const Color(0xFF4CAF50); // Verde
    } else if (progress >= 50) {
      return const Color(0xFFD4AF37); // Dorado
    } else {
      return const Color(0xFF8B7355); // Bronce
    }
  }
}
