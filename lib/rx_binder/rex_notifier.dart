import 'package:flutter/material.dart';

///使用callback的形式管理通知
class RxNotifier {
  List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void remove(VoidCallback listener) {
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  ///通知
  void notify() {
    if (_listeners.isEmpty) return;
    for (final entry in _listeners) {
      entry.call();
    }
  }
}
