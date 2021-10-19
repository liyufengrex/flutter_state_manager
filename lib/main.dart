import 'package:flutter/material.dart';
import 'package:test_state_manager/rx_interited/test.dart';

import 'rx_binder/test.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      // child: TestRxBinder(),
      child: TestWidget(),
    ),
  ));
}
