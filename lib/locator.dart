import 'package:flutter_assessment/core/services/service.dart';
import 'package:flutter_assessment/core/viewmodel/market_stock_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => MarketStockViewModel());
  locator.registerLazySingleton(() => ServiceAPI());
}