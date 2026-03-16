import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/album_provider.dart';
import '../models/series.dart';
import '../widgets/stamp_card.dart';

class SeriesScreen extends StatelessWidget {
  final Series series;

  const SeriesScreen({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    print('🎴 SERIES SCREEN BUILD - serie: ${series.name}');

    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        final totalStamps = series.stamps.length;
        final progress = series.getProgressPercentage(
          albumProvider.collectedStampIds,
        );
        final isComplete = progress == 100 && totalStamps > 0;

        final isMobile = MediaQuery.of(context).size.width < 800;
        final crossAxisCount = isMobile ? 3 : 5;

        return Scaffold(
          backgroundColor: const Color(0xFF1A0F0A),
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
                _buildSeriesInfo(series, progress, totalStamps, isComplete),
                _buildDivider(),
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

  Widget _buildSeriesInfo(
    Series series,
    int progress,
    int totalStamps,
    bool isComplete,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
                        color: const Color(0xFF6B4423),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (series.description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              series.description,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: const Color(0xFF5A3921),
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 16),
          _buildProgressBar(progress, totalStamps),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int progress, int totalStamps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: totalStamps > 0 ? progress / 100 : 0,
            backgroundColor: const Color(0xFFE0E0E0),
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(progress),
            ),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$progress% completado',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 13,
                color: const Color(0xFF5A3921),
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

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFFD4AF37).withValues(alpha: 0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildStampsGrid(
    Series series,
    AlbumProvider provider,
    int crossAxisCount,
  ) {
    if (series.stamps.isEmpty) {
      return _buildEmptyStampsState();
    }

    return // En el método _buildStampsGrid():
    GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        // ✅ CAMBIO CLAVE: Aspect ratio aumentado para cards más bajas
        childAspectRatio: 1.2, // Antes: 0.75 (más alto) | Ahora: 1.2 (más bajo)
        crossAxisSpacing: 8, // ✅ Espaciado reducido
        mainAxisSpacing: 8, // ✅ Espaciado reducido
      ),
      itemCount: series.stamps.length,
      itemBuilder: (context, index) {
        final stamp = series.stamps[index];
        return StampCard(stamp: stamp);
      },
    );
  }

  Widget _buildEmptyStampsState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_post_office,
              size: 80,
              color: const Color(0xFFAAAAAA),
            ),
            const SizedBox(height: 20),
            Text(
              'Próximamente',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Los sellos de esta serie\nestarán disponibles pronto',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: const Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                color: const Color(0xFF5A3921),
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
