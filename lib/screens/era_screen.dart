import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/album_provider.dart';
import '../data/stamp_database.dart';
import '../models/era.dart';
import '../models/series.dart';
import 'series_screen.dart';

class EraScreen extends StatelessWidget {
  final String eraId;

  const EraScreen({super.key, required this.eraId});

  @override
  Widget build(BuildContext context) {
    print('📅 ERA SCREEN BUILD - eraId: $eraId');
    
    final Era era;
    try {
      era = StampDatabase.getEraById(eraId);
      print('✅ Era encontrada: ${era.title}');
      print('📊 Series en esta era: ${era.series.length}');
    } catch (e) {
      print('❌ Error obteniendo era: $e');
      return _buildErrorState('Época no encontrada: $eraId');
    }

    return Consumer<AlbumProvider>(
      builder: (context, albumProvider, child) {
        print('🔄 Consumer builder ejecutado');
        final progress = albumProvider.getProgressPercentage(eraId);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                era.title,
                style: GoogleFonts.cinzel(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C1810),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${era.startYear} - ${era.endYear} • $progress% completado',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 14,
                  color: const Color(0xFF6B4423),
                ),
              ),
              const SizedBox(height: 24),
              if (era.series.isEmpty)
                _buildEmptySeriesState()
              else
                _buildSeriesList(context, era.series, albumProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSeriesList(
    BuildContext context,
    List<Series> seriesList,
    AlbumProvider provider,
  ) {
    print('📋 _buildSeriesList - Total series: ${seriesList.length}');
    
    return Column(
      children: seriesList.map((series) {
        print('🔍 Renderizando serie: ${series.name}');
        return _buildSeriesCard(context, series, provider);
      }).toList(),
    );
  }

  Widget _buildSeriesCard(
    BuildContext context,
    Series series,
    AlbumProvider provider,
  ) {
    print('🃏 _buildSeriesCard - Serie: ${series.name}');
    
    final progress = series.getProgressPercentage(provider.collectedStampIds);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('✅✅✅ CLICK DETECTADO en serie: ${series.name}');
        print('🔍 Navegando a SeriesScreen...');
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesScreen(series: series),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF0E6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD4AF37),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.folder,
                  color: Color(0xFFD4AF37),
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
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${series.startYear} - ${series.endYear}',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 13,
                        color: const Color(0xFF6B4423),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${series.stamps.length} sellos ($progress%)',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 12,
                        color: const Color(0xFF5A3921),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF8B6F47),
                size: 16,
              ),
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
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFB0B0B0),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.folder_off,
            size: 60,
            color: const Color(0xFF888888),
          ),
          const SizedBox(height: 16),
          Text(
            'Próximamente',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Las series de esta época\nestarán disponibles pronto',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 14,
              color: const Color(0xFF666666),
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
          children: [
            Icon(
              Icons.error_outline,
              size: 60,
              color: const Color(0xFFD32F2F),
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFB71C1C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 14,
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}