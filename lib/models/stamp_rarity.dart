import 'package:flutter/material.dart';

/// Niveles de rareza de los sellos coleccionables.
enum StampRarity {
  comun,
  pocoComun,
  raro,
  muyRaro,
}

/// Extensión para añadir propiedades y métodos al enum StampRarity
extension StampRarityExtension on StampRarity {
  Color get color {
    switch (this) {
      case StampRarity.comun:
        return const Color(0xFF8B7355);
      case StampRarity.pocoComun:
        return const Color(0xFFD4AF37);
      case StampRarity.raro:
        return const Color(0xFFC0C0C0);
      case StampRarity.muyRaro:
        return const Color(0xFFE5E4E2);
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

  Color get backgroundColor {
    switch (this) {
      case StampRarity.comun:
        return const Color(0xFF8B7355).withValues(alpha: 0.2);
      case StampRarity.pocoComun:
        return const Color(0xFFD4AF37).withValues(alpha: 0.2);
      case StampRarity.raro:
        return const Color(0xFFC0C0C0).withValues(alpha: 0.2);
      case StampRarity.muyRaro:
        return const Color(0xFFE5E4E2).withValues(alpha: 0.2);
    }
  }

  double get probability {
    switch (this) {
      case StampRarity.comun:
        return 0.60;
      case StampRarity.pocoComun:
        return 0.25;
      case StampRarity.raro:
        return 0.12;
      case StampRarity.muyRaro:
        return 0.03;
    }
  }

  String get displayName {
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

  int get valueMultiplier {
    switch (this) {
      case StampRarity.comun:
        return 1;
      case StampRarity.pocoComun:
        return 3;
      case StampRarity.raro:
        return 10;
      case StampRarity.muyRaro:
        return 50;
    }
  }

  String toJson() => name;
}

/// ✅ MÉTODO ESTÁTICO FUERA DE LA EXTENSIÓN (nivel superior)
/// Convierte un String a StampRarity (para cargar desde JSON)
StampRarity stampRarityFromString(String value) {
  switch (value) {
    case 'comun':
      return StampRarity.comun;
    case 'pocoComun':
      return StampRarity.pocoComun;
    case 'raro':
      return StampRarity.raro;
    case 'muyRaro':
      return StampRarity.muyRaro;
    default:
      return StampRarity.comun;
  }
}