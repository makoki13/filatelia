import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/album_provider.dart';
import '../data/stamp_database.dart';
import '../models/era.dart';
import '../models/series.dart';
import 'series_screen.dart';

/// Pantalla de detalle de una época histórica.
class EraScreen extends StatelessWidget {
  final String eraId;

  const EraScreen({super.key, required this.eraId});

  @override
  Widget build(BuildContext context) {
    final Era era;
    try {
      era = StampDatabase.getEraById(eraId);
    } catch (e) {
      return _buildErrorState('Época no encontrada: $eraId');
    }

    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        final progress = albumProvider.getProgressPercentage(eraId);
        final collectedStamps = era.countCollectedStamps(
          albumProvider.collectedStampIds,
        );
        final totalStamps = era.totalStamps;
        final isComplete = progress == 100 && totalStamps > 0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEraHeader(
                era,
                progress,
                collectedStamps,
                totalStamps,
                isComplete,
              ),
              const SizedBox(height: 24),
              _buildDivider(),
              const SizedBox(height: 24),
              _buildSeriesTitle(era.series.length),
              const SizedBox(height: 16),

              if (era.series.isEmpty)
                _buildEmptySeriesState()
              else
                _buildSeriesColumn(context, era, albumProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEraHeader(
    Era era,
    int progress,
    int collectedStamps,
    int totalStamps,
    bool isComplete,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFD4AF37),
            const Color(0xFFB8941F),
            const Color(0xFF8B6914),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8B6914), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isComplete) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            era.title,
            style: GoogleFonts.cinzel(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1810),
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            era.subtitle,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF4A3420),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF2C1810).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${era.startYear} - ${era.endYear} (${era.duration} años)',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C1810),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            era.description,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 15,
              color: const Color(0xFF4A3420),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildProgressBar(progress, collectedStamps, totalStamps),
        ],
      ),
    );
  }

  Widget _buildProgressBar(int progress, int collectedStamps, int totalStamps) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: totalStamps > 0 ? progress / 100 : 0,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(progress),
            ),
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$collectedStamps de $totalStamps sellos',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C1810),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _getProgressColor(progress),
                borderRadius: BorderRadius.circular(12),
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
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFFD4AF37).withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.auto_stories,
            color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
            size: 20,
          ),
        ),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFFD4AF37).withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeriesTitle(int seriesCount) {
    return Row(
      children: [
        Icon(Icons.folder_open, color: const Color(0xFF8B4513), size: 24),
        const SizedBox(width: 12),
        Text(
          'Series de esta época',
          style: GoogleFonts.cinzel(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C1810),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$seriesCount',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C1810),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeriesColumn(
    BuildContext context,
    Era era,
    AlbumProvider provider,
  ) {
    return Column(
      children: era.series.map((series) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildSeriesCard(context, series, provider),
        );
      }).toList(),
    );
  }

  Widget _buildSeriesCard(
    BuildContext context,
    Series series,
    AlbumProvider provider,
  ) {
    final totalStamps = series.stamps.length;
    final collectedStamps = series.countCollectedStamps(
      provider.collectedStampIds,
    );
    final progress = series.getProgressPercentage(provider.collectedStampIds);
    final isComplete = progress == 100 && totalStamps > 0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('✅ CLICK en serie: ${series.name}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeriesScreen(series: series)),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF0E6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isComplete
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFD4AF37),
              width: isComplete ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isComplete
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFD4AF37).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isComplete ? Icons.check_circle : Icons.folder,
                  color: isComplete ? Colors.white : const Color(0xFFD4AF37),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      series.name,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C1810),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${series.startYear} - ${series.endYear}',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 13,
                        color: Colors.brown[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: totalStamps > 0 ? progress / 100 : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isComplete
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFD4AF37),
                        ),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$collectedStamps / $totalStamps sellos ($progress%)',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 12,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.brown[400], size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySeriesState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!, width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.folder_off, size: 60, color: Colors.grey[500]),
          const SizedBox(height: 16),
          Text(
            'Próximamente',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Las series de esta época\nestarán disponibles pronto',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
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
