import 'dart:async';
import 'package:flutter/material.dart';

/// Callback que cada ItemsCollection registra para que el provider
/// pueda pedirle que guarde cuando el timer dispara.
typedef SaveCallback = Future<void> Function();

class EditingSessionProvider extends ChangeNotifier {
  Timer? _inactivityTimer;
  bool _isEditing = false;

  bool get isEditing => _isEditing;

  // Cada ItemsCollection se registra aquí con su función de guardado.
  final Map<String, SaveCallback> _saveCallbacks = {};

  void registerSaveCallback(String key, SaveCallback cb) {
    _saveCallbacks[key] = cb;
  }

  void unregisterSaveCallback(String key) {
    _saveCallbacks.remove(key);
  }

  /// Llámalo cuando cualquier campo gane foco.
  void onUserStartedEditing() {
    _inactivityTimer?.cancel();
    if (!_isEditing) {
      _isEditing = true;
      notifyListeners(); // los streams se cancelan
    }
  }

  /// Llámalo cuando cualquier campo pierda foco.
  void onUserStoppedEditing() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 1), _onInactivityTimerFired);
  }

  Future<void> _onInactivityTimerFired() async {
    // Guarda todo lo pendiente en paralelo.
    await Future.wait(_saveCallbacks.values.map((cb) => cb()));
    _isEditing = false;
    notifyListeners(); // los streams se reanudan
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }
}