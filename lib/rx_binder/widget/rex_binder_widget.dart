import 'package:flutter/material.dart';
import 'package:test_state_manager/rx_binder/rex_binder.dart';

typedef WidgetCallback = Widget Function(BuildContext context);

class RxBindWidget extends StatefulWidget {
  final WidgetCallback builder;
  final List<RxBinderData> binders;

  const RxBindWidget(this.builder, this.binders, {Key? key}) : super(key: key);

  @override
  _RxBindWidgetState createState() => _RxBindWidgetState();
}

class _RxBindWidgetState extends State<RxBindWidget> {
  RxBinder rxBinder = RxBinder();

  @override
  void initState() {
    super.initState();
    for (final entity in widget.binders) {
      //数据源绑定Rx
      entity.bindRx(rxBinder);
      rxBinder.addListener(entity.uuid, notifyDataChange);
    }
  }

  void notifyDataChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
