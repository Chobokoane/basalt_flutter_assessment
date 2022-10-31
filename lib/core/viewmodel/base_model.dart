import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/enums/viewstate.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  List<int> loadingItems = [];

  ViewState get state => _state;

  void setState(ViewState viewState) {
    if(viewState == ViewState.Busy) {
      _state = viewState;
      notifyListeners();
      loadingItems.add(loadingItems.length);
    } else {
      if(loadingItems.isNotEmpty) {
        loadingItems.removeLast();
      }
      if(loadingItems.isEmpty) {
        _state = viewState;
        notifyListeners();
      }
    }

  }
}