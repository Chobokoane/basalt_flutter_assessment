import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/ui/helper/ui_helpers.dart';
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
  bool isInternetPresent = true;

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
   _checkInternetConnectivity() {
    (Connectivity().checkConnectivity()).then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        if (widget.onModelReady != null) {
          widget.onModelReady(model);
        }
        isInternetPresent = true;
      } else {
        isInternetPresent = false;
        UIHelper.showDialogTwoActions(
            context, "No Internet Access", const Text("Please check your Internet connectivity to continue using the app"), _onClickRetry, "Retry", _onClickCancel, "Cancel");
      }
    }).catchError((error) {
      isInternetPresent = false;
      UIHelper.showDialogTwoActions(
          context, "No Internet Access", const Text("Please check your Internet connectivity to continue using the app"), _onClickRetry, "Retry", _onClickCancel, "Cancel");
    });
  }

  _onClickRetry() {
    _checkInternetConnectivity();
  }
  _onClickCancel() {
    Navigator.pop(context);
  }
}
