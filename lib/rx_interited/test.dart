import 'package:flutter/material.dart';
import 'package:test_state_manager/rx_interited/rx_provider.dart';
import 'package:test_state_manager/rx_interited/rx_tool.dart';

class Counter extends ChangeNotifier {
  int count = 0;

  void increase() {
    ++count;
    notifyListeners();
  }
}

class TestWidget extends StatelessWidget {
  TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RxInheritedProvider(
          create: Counter(),
          builder: (context) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _child(),
                  Builder(builder: (context) {
                    return TextButton(
                        child: Text("自增"),
                        onPressed: () {
                          RxTool.of<Counter>(context).increase();
                        });
                  }),
                ],
              ),
            );
          }),
    );
  }

  Widget _child() {
    return ConsumerBuilder<Counter>(builder: (context, counter) {
      return Text(
        '点击了 ${counter.count} 次',
        style: TextStyle(fontSize: 30.0),
      );
    });
  }
}
