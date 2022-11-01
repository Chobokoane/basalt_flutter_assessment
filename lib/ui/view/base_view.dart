import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onModelReady;
  final Function? onViewDispose;
  final Function()? onDestroy;

  BaseView({required this.builder, required this.onModelReady, this.onViewDispose, this.onDestroy});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: model,
        child: Consumer<T>(builder: widget.builder)
    );
  }

  @override
  dispose() {
    if(widget.onViewDispose != null) {
      widget.onViewDispose!();
    }
    super.dispose();
  }
  
}
