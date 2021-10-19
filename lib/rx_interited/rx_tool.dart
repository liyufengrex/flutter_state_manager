import 'package:flutter/material.dart';
import 'package:test_state_manager/rx_interited/rx_provider.dart';

abstract class RxTool {
  static T of<T extends ChangeNotifier>(BuildContext context) {
    return (_getInheritedElement<T>(context).widget as RxInheritedWidget<T>).value;
  }

  static void register<T extends ChangeNotifier>(BuildContext context) {
    var element = _getInheritedElement<T>(context);
    // context.dependOnInheritedElement(element);

    context.dependOnInheritedWidgetOfExactType<RxInheritedWidget<T>>(aspect: element.widget);

    //这种方式不产生关联关系
    // context.getElementForInheritedWidgetOfExactType<RxInheritedWidget<T>>();
  }

  static InheritedElement _getInheritedElement<T extends ChangeNotifier>(
      BuildContext context) {
    var element = context.getElementForInheritedWidgetOfExactType<RxInheritedWidget<T>>();
    if (element == null) {
      throw (Exception("RxInheritedWidget<${T.runtimeType}> is find null"));
    }
    return element;
  }
}
