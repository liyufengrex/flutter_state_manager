import 'package:flutter/material.dart';

import 'rx_tool.dart';

class RxInheritedProvider<T extends ChangeNotifier> extends StatelessWidget {
  final T create;
  final Widget Function(BuildContext context) builder;

  const RxInheritedProvider({
    Key? key,
    required this.create,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RxInheritedWidget(
      child: Builder(builder: (context) => builder(context)),
      value: create,
    );
  }
}

class RxInheritedWidget<T extends ChangeNotifier> extends InheritedNotifier<T> {
  RxInheritedWidget({
    required T value,
    required Widget child,
  }) : super(notifier: value, child: child);

  get value => this.notifier;
}

class ConsumerBuilder<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T value) builder;

  const ConsumerBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxTool.register<T>(context);
    return builder(
      context,
      RxTool.of<T>(context),
    );
  }
}
