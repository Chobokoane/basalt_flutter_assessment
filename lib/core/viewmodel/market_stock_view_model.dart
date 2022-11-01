import 'dart:async';
import 'package:flutter_assessment/core/viewmodel/base_model.dart';
import 'package:flutter_assessment/core/enums/viewstate.dart';
import 'package:flutter_assessment/core/model/market_stock_model.dart';
import 'package:flutter_assessment/core/services/service.dart';
import 'package:flutter_assessment/locator.dart';

class MarketStockViewModel extends BaseModel {
  String? errorMessage;
  String? successMessage;
  final ServiceAPI _service = locator<ServiceAPI>();
  MarketStockModel? marketData;
  List<Data>? listMarketData;

  Future getAllMarketStock() async {
    setState(ViewState.Busy);
    errorMessage = null;
    listMarketData= [];
    _service.getAllMarketStock().then((data) {
      if (data != null) {
        marketData = data;
        listMarketData = data.data;
        setState(ViewState.Idle);
      }
    }).catchError((error) {
      errorMessage = '${error.toString()}';
      setState(ViewState.Idle);
    });
  }
}
