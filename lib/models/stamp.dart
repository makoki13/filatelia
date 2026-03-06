// lib/models/stamp.dart
import 'stamp_rarity.dart';

class Stamp {
  final String id;
  final String seriesId;
  final String name;
  final double valuePesetas;
  final int year;
  final String description;
  final String imageBase64; // ← Cambiado de imagePath a imageBase64
  final StampRarity rarity;

  Stamp({
    required this.id,
    required this.seriesId,
    required this.name,
    required this.valuePesetas,
    required this.year,
    required this.description,
    required this.imageBase64,
    this.rarity = StampRarity.comun,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'seriesId': seriesId,
        'name': name,
        'value': valuePesetas,
        'year': year,
        'description': description,
        'imageBase64': imageBase64,
        'rarity': rarity.toJson(),
      };

  factory Stamp.fromJson(Map<String, dynamic> json) => Stamp(
        id: json['id'],
        seriesId: json['seriesId'],
        name: json['name'],
        valuePesetas: json['value'],
        year: json['year'],
        description: json['description'],
        imageBase64: json['imageBase64'] ?? '',
        rarity: stampRarityFromString(json['rarity'] ?? 'Común'),
      );
}