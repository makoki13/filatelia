import '../models/era.dart';
import '../models/series.dart';
import '../models/stamp.dart';
import '../models/stamp_rarity.dart';

/// Base de datos estática de sellos españoles en pesetas.
/// 
/// Contiene las 6 épocas históricas definidas para el álbum,
/// con sus series correspondientes y los sellos de cada serie.
/// 
/// Las imágenes están en formato Base64 para portabilidad entre
/// Windows y dispositivos móviles.
class StampDatabase {
  /// Lista principal de todas las épocas del álbum
  static final List<Era> eras = [
    // ─────────────────────────────────────────────────────────────────────
    // 1. REINADO DE ISABEL II (1850-1868)
    // ─────────────────────────────────────────────────────────────────────
    Era(
      id: 'isabel_ii',
      title: 'Reinado de Isabel II',
      subtitle: 'Inicios del sello español',
      startYear: 1850,
      endYear: 1868,
      description:
          'Los primeros sellos de España durante el reinado de Isabel II. '
          'La primera emisión de 1850 marcó el inicio de la filatelia española.',
      coverImagePath: '',
      series: [
        Series(
          id: 'isabel_ii_1850',
          eraId: 'isabel_ii',
          name: 'Emisión de 1850',
          startYear: 1850,
          endYear: 1851,
          description: 'Primera emisión de sellos españoles con el retrato de Isabel II.',
          stamps: [
            Stamp(
              id: 'isabel_ii_1850_6c',
              seriesId: 'isabel_ii_1850',
              name: '6 céntimos',
              valuePesetas: 0.06,
              year: 1850,
              description: 'Primer sello español. Color negro.',
              imageBase64: '',
              rarity: StampRarity.comun,
            ),
            Stamp(
              id: 'isabel_ii_1850_1r',
              seriesId: 'isabel_ii_1850',
              name: '1 real',
              valuePesetas: 0.25,
              year: 1850,
              description: 'Sello de 1 real. Color rojo.',
              imageBase64: '',
              rarity: StampRarity.pocoComun,
            ),
            Stamp(
              id: 'isabel_ii_1850_2r',
              seriesId: 'isabel_ii_1850',
              name: '2 reales',
              valuePesetas: 0.50,
              year: 1850,
              description: 'Sello de 2 reales. Color verde.',
              imageBase64: '',
              rarity: StampRarity.raro,
            ),
          ],
        ),
        Series(
          id: 'isabel_ii_1854',
          eraId: 'isabel_ii',
          name: 'Emisión de 1854',
          startYear: 1854,
          endYear: 1855,
          description: 'Nueva serie con cambios en el retrato real.',
          stamps: [
            Stamp(
              id: 'isabel_ii_1854_6c',
              seriesId: 'isabel_ii_1854',
              name: '6 céntimos',
              valuePesetas: 0.06,
              year: 1854,
              description: 'Segunda emisión de 6 céntimos.',
              imageBase64: '',
              rarity: StampRarity.comun,
            ),
            Stamp(
              id: 'isabel_ii_1854_1r',
              seriesId: 'isabel_ii_1854',
              name: '1 real',
              valuePesetas: 0.25,
              year: 1854,
              description: 'Segunda emisión de 1 real.',
              imageBase64: '',
              rarity: StampRarity.pocoComun,
            ),
          ],
        ),
      ],
    ),

    // ─────────────────────────────────────────────────────────────────────
    // 2. PROVISIONAL Y AMADEO DE SABOYA (1868-1873)
    // ─────────────────────────────────────────────────────────────────────
    Era(
      id: 'provisional_amadeo',
      title: 'Provisional y Amadeo de Saboya',
      subtitle: 'Sexenio Democrático',
      startYear: 1868,
      endYear: 1873,
      description:
          'Período de transición política tras la Revolución de 1868. '
          'Sellos del Gobierno Provisional y del reinado de Amadeo I de Saboya.',
      coverImagePath: '',
      series: [
        Series(
          id: 'provisional_1869',
          eraId: 'provisional_amadeo',
          name: 'Gobierno Provisional',
          startYear: 1869,
          endYear: 1870,
          description: 'Sellos con el escudo del Gobierno Provisional.',
          stamps: [
            Stamp(
              id: 'prov_1869_100m',
              seriesId: 'provisional_1869',
              name: '100 milésimas',
              valuePesetas: 0.10,
              year: 1869,
              description: 'Escudo provisional. Color azul.',
              imageBase64: '',
              rarity: StampRarity.pocoComun,
            ),
            Stamp(
              id: 'prov_1869_200m',
              seriesId: 'provisional_1869',
              name: '200 milésimas',
              valuePesetas: 0.20,
              year: 1869,
              description: 'Escudo provisional. Color rojo.',
              imageBase64: '',
              rarity: StampRarity.raro,
            ),
          ],
        ),
        Series(
          id: 'amadeo_1872',
          eraId: 'provisional_amadeo',
          name: 'Amadeo I',
          startYear: 1872,
          endYear: 1873,
          description: 'Sellos con el retrato de Amadeo de Saboya.',
          stamps: [
            Stamp(
              id: 'amadeo_1872_100m',
              seriesId: 'amadeo_1872',
              name: '100 milésimas',
              valuePesetas: 0.10,
              year: 1872,
              description: 'Retrato de Amadeo I.',
              imageBase64: '',
              rarity: StampRarity.muyRaro,
            ),
          ],
        ),
      ],
    ),

    // ─────────────────────────────────────────────────────────────────────
    // 3. RESTAURACIÓN BORBÓNICA (1875-1931)
    // ─────────────────────────────────────────────────────────────────────
    Era(
      id: 'restauracion',
      title: 'Restauración Borbónica',
      subtitle: 'Alfonso XII y Alfonso XIII',
      startYear: 1875,
      endYear: 1931,
      description:
          'Retorno de los Borbones al trono español. Período extenso con '
          'numerosas emisiones durante los reinados de Alfonso XII y Alfonso XIII.',
      coverImagePath: '',
      series: [
        Series(
          id: 'alfonso_xii_1876',
          eraId: 'restauracion',
          name: 'Alfonso XII - Primera Emisión',
          startYear: 1876,
          endYear: 1877,
          description: 'Primera emisión tras la Restauración.',
          stamps: [
            Stamp(
              id: 'alfonso_xii_1876_5c',
              seriesId: 'alfonso_xii_1876',
              name: '5 céntimos',
              valuePesetas: 0.05,
              year: 1876,
              description: 'Retrato de Alfonso XII.',
              imageBase64: '',
              rarity: StampRarity.comun,
            ),
            Stamp(
              id: 'alfonso_xii_1876_25c',
              seriesId: 'alfonso_xii_1876',
              name: '25 céntimos',
              valuePesetas: 0.25,
              year: 1876,
              description: 'Retrato de Alfonso XII. Color violeta.',
              imageBase64: '',
              rarity: StampRarity.pocoComun,
            ),
          ],
        ),
        Series(
          id: 'alfonso_xiii_1900',
          eraId: 'restauracion',
          name: 'Alfonso XIII - Serie Monumentos',
          startYear: 1900,
          endYear: 1905,
          description: 'Serie dedicada a monumentos españoles.',
          stamps: [
            Stamp(
              id: 'alfonso_xiii_1900_10c',
              seriesId: 'alfonso_xiii_1900',
              name: '10 céntimos - Catedral de León',
              valuePesetas: 0.10,
              year: 1900,
              description: 'Catedral de León.',
              imageBase64: '',
              rarity: StampRarity.raro,
            ),
            Stamp(
              id: 'alfonso_xiii_1900_50c',
              seriesId: 'alfonso_xiii_1900',
              name: '50 céntimos - Alhambra',
              valuePesetas: 0.50,
              year: 1900,
              description: 'La Alhambra de Granada.',
              imageBase64: '',
              rarity: StampRarity.muyRaro,
            ),
          ],
        ),
      ],
    ),

    // ─────────────────────────────────────────────────────────────────────
    // 4. SEGUNDA REPÚBLICA (1931-1936)
    // ─────────────────────────────────────────────────────────────────────
    Era(
      id: 'segunda_republica',
      title: 'Segunda República',
      subtitle: '1931-1936',
      startYear: 1931,
      endYear: 1936,
      description:
          'Período republicano español. Sellos con alegorías de la República '
          'y cambios iconográficos significativos.',
      coverImagePath: '',
      series: [
        Series(
          id: 'republica_1931',
          eraId: 'segunda_republica',
          name: 'Emisión de 1931',
          startYear: 1931,
          endYear: 1932,
          description: 'Primera emisión de la Segunda República.',
          stamps: [
            Stamp(
              id: 'republica_1931_5c',
              seriesId: 'republica_1931',
              name: '5 céntimos',
              valuePesetas: 0.05,
              year: 1931,
              description: 'Alegoría de la República.',
              imageBase64: '',
              rarity: StampRarity.comun,
            ),
            Stamp(
              id: 'republica_1931_error',
              seriesId: 'republica_1931',
              name: 'Error de impresión',
              valuePesetas: 0.50,
              year: 1931,
              description: 'Error de color - Muy pocos ejemplares.',
              imageBase64: '',
              rarity: StampRarity.muyRaro,
            ),
          ],
        ),
      ],
    ),

    // ─────────────────────────────────────────────────────────────────────
    // 5. ESTADO ESPAÑOL (1936-1975)
    // ─────────────────────────────────────────────────────────────────────
    Era(
      id: 'estado_espanol',
      title: 'Estado Español',
      subtitle: '1936-1975',
      startYear: 1936,
      endYear: 1975,
      description:
          'Período franquista. Numerosas emisiones conmemorativas, '
          'turísticas y de propaganda.',
      coverImagePath: '',
      series: [
        Series(
          id: 'franco_1940',
          eraId: 'estado_espanol',
          name: 'Franco Caudillo',
          startYear: 1940,
          endYear: 1945,
          description: 'Serie con el retrato del General Franco.',
          stamps: [
            Stamp(
              id: 'franco_1940_10c',
              seriesId: 'franco_1940',
              name: '10 céntimos',
              valuePesetas: 0.10,
              year: 1940,
              description: 'Retrato de Franco.',
              imageBase64: '',
              rarity: StampRarity.comun,
            ),
            Stamp(
              id: 'franco_1940_1pta',
              seriesId: 'franco_1940',
              name: '1 peseta',
              valuePesetas: 1.0,
              year: 1940,
              description: 'Retrato de Franco. Color verde.',
              imageBase64: '',
              rarity: StampRarity.pocoComun,
            ),
          ],
        ),
        Series(
          id: 'turismo_1955',
          eraId: 'estado_espanol',
          name: 'Serie Turismo',
          startYear: 1955,
          endYear: 1960,
          description: 'Serie dedicada al turismo en España.',
          stamps: [
            Stamp(
              id: 'turismo_1955_50c',
              seriesId: 'turismo_1955',
              name: '50 céntimos - Sevilla',
              valuePesetas: 0.50,
              year: 1955,
              description: 'Plaza de España, Sevilla.',
              imageBase64: '',
              rarity: StampRarity.raro,
            ),
          ],
        ),
      ],
    ),

    // ─────────────────────────────────────────────────────────────────────
    // 6. REINADO DE JUAN CARLOS I (1975-2001)
    // ─────────────────────────────────────────────────────────────────────
    Era(
      id: 'juan_carlos_i',
      title: 'Reinado de Juan Carlos I',
      subtitle: '1975-2001',
      startYear: 1975,
      endYear: 2001,
      description:
          'Transición democrática y reinado de Juan Carlos I. '
          'Últimos sellos en pesetas antes del euro.',
      coverImagePath: '',
      series: [
        Series(
          id: 'juan_carlos_1976',
          eraId: 'juan_carlos_i',
          name: 'Proclamación',
          startYear: 1976,
          endYear: 1977,
          description: 'Sellos conmemorativos de la proclamación.',
          stamps: [
            Stamp(
              id: 'juan_carlos_1976_5pta',
              seriesId: 'juan_carlos_1976',
              name: '5 pesetas',
              valuePesetas: 5.0,
              year: 1976,
              description: 'Proclamación de Juan Carlos I.',
              imageBase64: '',
              rarity: StampRarity.comun,
            ),
            Stamp(
              id: 'juan_carlos_1976_100pta',
              seriesId: 'juan_carlos_1976',
              name: '100 pesetas',
              valuePesetas: 100.0,
              year: 1976,
              description: 'Edición especial. Color oro.',
              imageBase64: '',
              rarity: StampRarity.muyRaro,
            ),
          ],
        ),
        Series(
          id: 'constitucion_1978',
          eraId: 'juan_carlos_i',
          name: 'Constitución de 1978',
          startYear: 1978,
          endYear: 1979,
          description: 'Serie conmemorativa de la Constitución.',
          stamps: [
            Stamp(
              id: 'constitucion_1978_10pta',
              seriesId: 'constitucion_1978',
              name: '10 pesetas',
              valuePesetas: 10.0,
              year: 1978,
              description: 'Constitución Española.',
              imageBase64: '',
              rarity: StampRarity.pocoComun,
            ),
          ],
        ),
      ],
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────
  // MÉTODOS DE BÚSQUEDA Y UTILIDAD
  // ─────────────────────────────────────────────────────────────────────

  /// Obtiene una época específica por su ID
  static Era getEraById(String id) {
    try {
      return eras.firstWhere((era) => era.id == id);
    } catch (e) {
      throw Exception('Era no encontrada: $id');
    }
  }

  /// Obtiene una serie específica por su ID (busca en todas las épocas)
  static Series getSeriesById(String id) {
    for (var era in eras) {
      for (var series in era.series) {
        if (series.id == id) return series;
      }
    }
    throw Exception('Serie no encontrada: $id');
  }

  /// Obtiene un sello específico por su ID (busca en todas las series)
  static Stamp getStampById(String id) {
    for (var era in eras) {
      for (var series in era.series) {
        for (var stamp in series.stamps) {
          if (stamp.id == id) return stamp;
        }
      }
    }
    throw Exception('Sello no encontrado: $id');
  }

  /// Obtiene todos los sellos de todas las épocas
  static List<Stamp> getAllStamps() {
    List<Stamp> allStamps = [];
    for (var era in eras) {
      for (var series in era.series) {
        allStamps.addAll(series.stamps);
      }
    }
    return allStamps;
  }

  /// Obtiene todos los sellos de una época específica
  static List<Stamp> getStampsByEra(String eraId) {
    final era = getEraById(eraId);
    List<Stamp> stamps = [];
    for (var series in era.series) {
      stamps.addAll(series.stamps);
    }
    return stamps;
  }

  /// Obtiene todos los sellos de una rareza específica
  static List<Stamp> getStampsByRarity(StampRarity rarity) {
    return getAllStamps().where((stamp) => stamp.rarity == rarity).toList();
  }

  /// Cuenta el número total de sellos en la base de datos
  static int get totalStampsCount => getAllStamps().length;

  /// Cuenta el número total de series en la base de datos
  static int get totalSeriesCount {
    int count = 0;
    for (var era in eras) {
      count += era.series.length;
    }
    return count;
  }

  /// Obtiene sellos aleatorios para un sobre sorpresa (con ponderación de rareza)
  static List<Stamp> getRandomStamps({int count = 3}) {
    List<Stamp> selectedStamps = [];
    final allStamps = getAllStamps();

    if (allStamps.isEmpty) return selectedStamps;

    for (int i = 0; i < count; i++) {
      final rarity = _getRandomRarity();
      final stampsByRarity = allStamps.where((s) => s.rarity == rarity).toList();

      if (stampsByRarity.isNotEmpty) {
        final randomIndex = DateTime.now().millisecond % stampsByRarity.length;
        selectedStamps.add(stampsByRarity[randomIndex]);
      } else {
        final randomIndex = DateTime.now().millisecond % allStamps.length;
        selectedStamps.add(allStamps[randomIndex]);
      }
    }

    return selectedStamps;
  }

  /// Genera una rareza aleatoria con ponderación
  static StampRarity _getRandomRarity() {
    final random = DateTime.now().millisecond % 100;

    if (random < 60) {
      return StampRarity.comun;
    } else if (random < 85) {
      return StampRarity.pocoComun;
    } else if (random < 97) {
      return StampRarity.raro;
    } else {
      return StampRarity.muyRaro;
    }
  }

  /// Obtiene estadísticas de rareza de toda la colección
  static Map<StampRarity, int> getRarityDistribution() {
    final distribution = <StampRarity, int>{
      StampRarity.comun: 0,
      StampRarity.pocoComun: 0,
      StampRarity.raro: 0,
      StampRarity.muyRaro: 0,
    };

    for (var stamp in getAllStamps()) {
      distribution[stamp.rarity] = (distribution[stamp.rarity] ?? 0) + 1;
    }

    return distribution;
  }
}