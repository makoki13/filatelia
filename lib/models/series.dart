import 'stamp.dart';

/// Representa una serie de sellos dentro de una época histórica.
/// 
/// Una serie agrupa sellos emitidos bajo un mismo criterio:
/// - Una emisión concreta (ej: "Emisión de 1850")
/// - Una temática (ej: "Monumentos de España")
/// - Un período de validez postal
class Series {
  /// Identificador único de la serie (ej: 'isabel_ii_1850')
  final String id;

  /// Referencia al ID de la época a la que pertenece esta serie
  final String eraId;

  /// Nombre descriptivo de la serie
  final String name;

  /// Año de inicio de la emisión de esta serie
  final int startYear;

  /// Año de fin de la emisión de esta serie
  final int endYear;

  /// Descripción histórica o filatélica de la serie
  final String description;

  /// Lista de sellos que componen esta serie
  final List<Stamp> stamps;

  /// Constructor principal
  Series({
    required this.id,
    required this.eraId,
    required this.name,
    required this.startYear,
    required this.endYear,
    required this.description,
    this.stamps = const [],
  });

  /// Convierte la instancia a un mapa JSON para persistencia
  Map<String, dynamic> toJson() => {
        'id': id,
        'eraId': eraId,
        'name': name,
        'startYear': startYear,
        'endYear': endYear,
        'description': description,
        'stamps': stamps.map((stamp) => stamp.toJson()).toList(),
      };

  /// Crea una instancia desde un mapa JSON (para cargar desde SharedPreferences)
  factory Series.fromJson(Map<String, dynamic> json) => Series(
        id: json['id'] as String,
        eraId: json['eraId'] as String,
        name: json['name'] as String,
        startYear: json['startYear'] as int,
        endYear: json['endYear'] as int,
        description: json['description'] as String,
        stamps: (json['stamps'] as List<dynamic>?)
                ?.map((s) => Stamp.fromJson(s as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  /// Calcula el número total de sellos en esta serie
  int get totalStamps => stamps.length;

  /// Calcula cuántos sellos de esta serie tiene el usuario coleccionados
  /// 
  /// Nota: Este método requiere pasar los IDs coleccionados externamente
  /// para mantener el modelo puro y testeable.
  int countCollectedStamps(Set<String> collectedStampIds) {
    return stamps.where((stamp) => collectedStampIds.contains(stamp.id)).length;
  }

  /// Calcula el porcentaje de progreso de esta serie (0-100)
  int getProgressPercentage(Set<String> collectedStampIds) {
    if (stamps.isEmpty) return 0;
    final collected = countCollectedStamps(collectedStampIds);
    return ((collected / stamps.length) * 100).round();
  }

  @override
  String toString() => 'Series{id: $id, name: $name, stamps: ${stamps.length}}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Series && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}