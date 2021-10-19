import 'package:test_state_manager/rx_binder/rex_binder.dart';

///基础数据类型以int作为栗子
extension IntExtension on int {
  RxInt get rex => RxInt(this);

  //绑定Rx通知
  void bindRx(RxBinder? value) {
    rex.bindRx(value);
  }
}

///具体业务的扩展类
class RxInt extends RxBinderData<int> {
  RxInt(int value) : super(value);

  RxInt operator +(int other) {
    value = value + other;
    return this;
  }

  RxInt operator -(int other) {
    value = value - other;
    return this;
  }
}
