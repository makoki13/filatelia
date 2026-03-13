import 'stamp_rarity.dart';

class Stamp {
  final String id;
  final String seriesId;
  final String name;
  final double valuePesetas;
  final int year;
  final String description;
  final String imageBase64;
  final StampRarity rarity;

  Stamp({
    required this.id,
    required this.seriesId,
    required this.name,
    required this.valuePesetas,
    required this.year,
    required this.description,
    required this.imageBase64,
    required this.rarity,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'seriesId': seriesId,
    'name': name,
    'valuePesetas': valuePesetas,
    'year': year,
    'description': description,
    'imageBase64': imageBase64,
    'rarity': rarity.toJson(),
  };

  /// ✅ CORREGIDO: Usa la función stampRarityFromString (nivel superior)
  factory Stamp.fromJson(Map<String, dynamic> json) => Stamp(
    id: json['id'] as String,
    seriesId: json['seriesId'] as String,
    name: json['name'] as String,
    valuePesetas: (json['valuePesetas'] as num).toDouble(),
    year: json['year'] as int,
    description: json['description'] as String,
    imageBase64: json['imageBase64'] as String,
    rarity: stampRarityFromString(json['rarity'] as String),
  );

  @override
  String toString() => 'Stamp{id: $id, name: $name, rarity: $rarity}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stamp && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
