import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'rex_notifier.dart';

class RxBinder {
  Map<RxNotifier, String> _subjects = {};

  ///订阅者， key是订阅的数据id， value是订阅数据发生变化时的通知回调
  Map<String, List<VoidCallback>> _subscriber = {};

  //注册
  void register(String uuid, RxNotifier subject) {
    if (!_subjects.containsKey(subject)) {
      subject.addListener(() {
        _notify(uuid);
      });
      _subjects[subject] = '';
    }
  }

  //添加订阅关系
  void addListener(String uuid, VoidCallback listener) {
    if (!_subscriber.containsKey(uuid)) {
      //key不存在
      _subscriber[uuid] = [listener];
    } else {
      //key已存在
      List<VoidCallback> list = _subscriber[uuid]!;
      if (!list.contains(listener)) {
        list.add(listener);
        _subscriber[uuid] = list;
      }
    }
  }

  //通知订阅者
  void _notify(String uuid) {
    if (_subscriber.containsKey(uuid)) {
      final list = _subscriber[uuid];
      if (list != null && list.isNotEmpty) {
        for (final entry in list) {
          entry.call();
        }
      }
    }
  }
}

///数据模型基类，（封装变更通知）
class RxBinderData<T> {
  late T _value;
  late String uuid;
  RxNotifier subject = RxNotifier();
  RxBinder? _rxBinder;

  RxBinderData(this._value, {RxBinder? value}) {
    uuid = Uuid().v4();
    bindRx(value);
  }

  void bindRx(RxBinder? value) {
    _rxBinder = value;
  }

  @override
  String toString() {
    return value.toString();
  }

  T get value {
    //添加监听，变更通知注册
    _rxBinder?.register(uuid, subject);
    return _value;
  }

  set value(T val) {
    _value = val;
    notify();
  }

  void notify() {
    //通知数据发生变更
    subject.notify();
  }
}
