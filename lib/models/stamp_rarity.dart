import 'package:flutter/material.dart';

enum StampRarity {
  comun,
  pocoComun,
  raro,
  muyRaro,
}

extension StampRarityExtension on StampRarity {
  String get name {
    switch (this) {
      case StampRarity.comun:
        return 'Común';
      case StampRarity.pocoComun:
        return 'Poco Común';
      case StampRarity.raro:
        return 'Raro';
      case StampRarity.muyRaro:
        return 'Muy Raro';
    }
  }

  String get code {
    switch (this) {
      case StampRarity.comun:
        return 'C';
      case StampRarity.pocoComun:
        return 'PC';
      case StampRarity.raro:
        return 'R';
      case StampRarity.muyRaro:
        return 'MR';
    }
  }

  Color get color {
    switch (this) {
      case StampRarity.comun:
        return const Color(0xFF8B7355);
      case StampRarity.pocoComun:
        return const Color(0xFFC0C0C0);
      case StampRarity.raro:
        return const Color(0xFFD4AF37);
      case StampRarity.muyRaro:
        return const Color(0xFFE74C3C);
    }
  }

  Color get backgroundColor {
    switch (this) {
      case StampRarity.comun:
        return const Color(0xFF8B7355).withOpacity(0.2);
      case StampRarity.pocoComun:
        return const Color(0xFFC0C0C0).withOpacity(0.2);
      case StampRarity.raro:
        return const Color(0xFFD4AF37).withOpacity(0.2);
      case StampRarity.muyRaro:
        return const Color(0xFFE74C3C).withOpacity(0.2);
    }
  }

  IconData get icon {
    switch (this) {
      case StampRarity.comun:
        return Icons.circle;
      case StampRarity.pocoComun:
        return Icons.star;
      case StampRarity.raro:
        return Icons.star_rate;
      case StampRarity.muyRaro:
        return Icons.auto_awesome;
    }
  }

  // Para guardar en JSON
  String toJson() => name;
}

// ✅ Función helper externa para convertir desde JSON
StampRarity stampRarityFromString(String value) {
  switch (value) {
    case 'Común':
      return StampRarity.comun;
    case 'Poco Común':
      return StampRarity.pocoComun;
    case 'Raro':
      return StampRarity.raro;
    case 'Muy Raro':
      return StampRarity.muyRaro;
    default:
      return StampRarity.comun;
  }
}