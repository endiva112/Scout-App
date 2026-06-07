import 'dart:async';
import 'package:flutter/material.dart';

typedef SaveCallback = Future<void> Function();

class EditingSessionProvider extends ChangeNotifier {
  Timer? _inactivityTimer;
  bool _isEditing = false;

  bool get isEditing => _isEditing;

  final Map<String, SaveCallback> _saveCallbacks = {};

  void registerSaveCallback(String key, SaveCallback cb) {
    _saveCallbacks[key] = cb;
  }

  void unregisterSaveCallback(String key) {
    _saveCallbacks.remove(key);
  }

  void onUserStartedEditing() {
    _inactivityTimer?.cancel();
    if (!_isEditing) {
      _isEditing = true;
      notifyListeners();
    }
  }

  void onUserStoppedEditing() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 1), _onInactivityTimerFired);
  }

  Future<void> _onInactivityTimerFired() async {
    await saveNow();
  }

  /// Fuerza el guardado inmediato de todo lo pendiente.
  /// Llamar antes de salir de la pantalla.
  Future<void> saveNow() async {
    _inactivityTimer?.cancel();
    await Future.wait(_saveCallbacks.values.map((cb) => cb()));
    _isEditing = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }
}