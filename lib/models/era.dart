import 'series.dart';

/// Representa una época histórica del álbum de sellos españoles.
/// 
/// Cada época es un "capítulo" del álbum que agrupa múltiples series
/// de sellos emitidos durante un período histórico concreto.
/// 
/// Ejemplos:
/// - Reinado de Isabel II (1850-1868)
/// - Segunda República (1931-1936)
/// - Reinado de Juan Carlos I (1975-2001)
class Era {
  /// Identificador único de la época (ej: 'isabel_ii', 'segunda_republica')
  final String id;

  /// Título principal de la época (ej: 'Reinado de Isabel II')
  final String title;

  /// Subtítulo o descripción corta (ej: 'Inicios del sello español')
  final String subtitle;

  /// Año de inicio del período histórico
  final int startYear;

  /// Año de fin del período histórico
  final int endYear;

  /// Descripción histórica detallada de la época
  final String description;

  /// Ruta de la imagen de portada de esta época (en Base64 o assets)
  final String coverImagePath;

  /// Lista de series que pertenecen a esta época
  final List<Series> series;

  /// Constructor principal
  Era({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.startYear,
    required this.endYear,
    required this.description,
    required this.coverImagePath,
    this.series = const [],
  });

  /// Convierte la instancia a un mapa JSON para persistencia
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'startYear': startYear,
        'endYear': endYear,
        'description': description,
        'coverImage': coverImagePath,
        'series': series.map((s) => s.toJson()).toList(),
      };

  /// Crea una instancia desde un mapa JSON (para cargar desde SharedPreferences)
  factory Era.fromJson(Map<String, dynamic> json) => Era(
        id: json['id'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        startYear: json['startYear'] as int,
        endYear: json['endYear'] as int,
        description: json['description'] as String,
        coverImagePath: json['coverImage'] as String,
        series: (json['series'] as List<dynamic>?)
                ?.map((s) => Series.fromJson(s as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  /// Calcula el número total de sellos en todas las series de esta época
  int get totalStamps {
    return series.fold(0, (sum, s) => sum + s.stamps.length);
  }

  /// Calcula cuántos sellos de esta época tiene el usuario coleccionados
  int countCollectedStamps(Set<String> collectedStampIds) {
    int count = 0;
    for (var serie in series) {
      count += serie.countCollectedStamps(collectedStampIds);
    }
    return count;
  }

  /// Calcula el porcentaje de progreso de esta época (0-100)
  int getProgressPercentage(Set<String> collectedStampIds) {
    final total = totalStamps;
    if (total == 0) return 0;
    final collected = countCollectedStamps(collectedStampIds);
    return ((collected / total) * 100).round();
  }

  /// Obtiene una serie específica por su ID dentro de esta época
  Series? getSeriesById(String seriesId) {
    try {
      return series.firstWhere((s) => s.id == seriesId);
    } catch (e) {
      return null;
    }
  }

  /// Verifica si esta época está completamente completada
  bool isComplete(Set<String> collectedStampIds) {
    return countCollectedStamps(collectedStampIds) == totalStamps;
  }

  /// Verifica si esta época no tiene ninguna serie registrada aún
  bool get isEmpty => series.isEmpty;

  /// Duración del período en años
  int get duration => endYear - startYear;

  @override
  String toString() => 'Era{id: $id, title: $title, series: ${series.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Era && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}