import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/stamp_database.dart';

/// Gestiona el estado de la colección de sellos del usuario.
/// 
/// Este provider actúa como la única fuente de verdad para saber
/// qué sellos tiene el usuario en su colección.
class AlbumProvider extends ChangeNotifier {
  // ✅ ÚNICA FUENTE DE VERDAD: IDs de sellos coleccionados
  final Set<String> _collectedStampIds = {};
  
  bool _isLoading = true;

  // Getters públicos
  Set<String> get collectedStampIds => _collectedStampIds;
  bool get isLoading => _isLoading;

  AlbumProvider() {
    _loadCollection();
  }

  // Cargar la colección guardada
  Future<void> _loadCollection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedIds = prefs.getStringList('collected_stamps');
      
      if (savedIds != null) {
        _collectedStampIds.addAll(savedIds);
      }
    } catch (e) {
      debugPrint('Error cargando colección: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }

  // Guardar la colección
  Future<void> _saveCollection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('collected_stamps', _collectedStampIds.toList());
    } catch (e) {
      debugPrint('Error guardando colección: $e');
    }
  }

  // ✅ MÉTODO CLAVE: Verificar si un sello está en la colección
  bool isStampCollected(String stampId) {
    return _collectedStampIds.contains(stampId);
  }

  // Añadir un sello a la colección
  Future<void> addStamp(String stampId) async {
    if (!_collectedStampIds.contains(stampId)) {
      _collectedStampIds.add(stampId);
      await _saveCollection();
      notifyListeners();
    }
  }

  // Añadir múltiples sellos (al abrir un sobre)
  Future<void> addMultipleStamps(List<String> stampIds) async {
    bool changed = false;
    for (var id in stampIds) {
      if (!_collectedStampIds.contains(id)) {
        _collectedStampIds.add(id);
        changed = true;
      }
    }
    
    if (changed) {
      await _saveCollection();
      notifyListeners();
    }
  }
  
  // ✅ NUEVO MÉTODO: Progreso por época (recibe eraId como String)
  int getProgressPercentage(String eraId) {
    try {
      final era = StampDatabase.getEraById(eraId);
      final totalStamps = era.totalStamps;
      
      if (totalStamps == 0) return 0;
      
      final collectedCount = era.countCollectedStamps(_collectedStampIds);
      return ((collectedCount / totalStamps) * 100).round();
    } catch (e) {
      debugPrint('Error calculando progreso para era $eraId: $e');
      return 0;
    }
  }

  // Progreso global (todos los sellos)
  int get globalProgressPercentage {
    final totalStamps = StampDatabase.totalStampsCount;
    if (totalStamps == 0) return 0;
    return ((_collectedStampIds.length / totalStamps) * 100).round();
  }
  
  // Contador de sellos coleccionados
  int get collectedCount => _collectedStampIds.length;

  // Contador total de sellos disponibles
  int get totalStampsCount => StampDatabase.totalStampsCount;
}