import 'dart:async';
import 'package:flutter_assessment/core/viewmodel/base_model.dart';
import 'package:flutter_assessment/core/enums/viewstate.dart';
import 'package:flutter_assessment/model/market_stock_model.dart';
import 'package:flutter_assessment/core/services/service.dart';
import 'package:flutter_assessment/locator.dart';

class MarketStockViewModel extends BaseModel {
  String? errorMessage;
  String? successMessage;
  final ServiceAPI _service = locator<ServiceAPI>();
  MarketStockModel? marketData;

  void getAllMarketStock() async {
    setState(ViewState.Busy);
    errorMessage = null;
    successMessage = null;
    return _service.getAllMarketStock().then((data) async {
      if (data.data!.isNotEmpty) {
        marketData = data;
        setState(ViewState.Idle);
      }
    }).catchError((error) {
      errorMessage = '${error.toString()}';
    });
  }
}