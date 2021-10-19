import 'package:flutter/material.dart';
import 'package:test_state_manager/rx_binder/rex_extension.dart';
import 'package:test_state_manager/rx_binder/widget/rex_binder_widget.dart';

class Logic {
  RxInt count = 0.rex;

  void increase() => ++count;
}

class TestRxBinder extends StatelessWidget {
  final Logic logic = Logic();

  TestRxBinder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RxBindWidget((context) {
          return _child(context);
        }, [logic.count]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logic.increase(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _child(BuildContext context) {
    return Text(
      '点击了 ${logic.count.value} 次',
      style: TextStyle(fontSize: 30.0),
    );
  }
}
