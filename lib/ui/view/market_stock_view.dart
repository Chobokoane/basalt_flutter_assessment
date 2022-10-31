import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/viewmodel/market_stock_view_model.dart';
import 'package:flutter_assessment/ui/widget/market_stock_widget.dart';
import 'package:flutter_assessment/ui/view/base_view.dart';

class MarketStockyView extends StatelessWidget {
  const MarketStockyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MarketStockViewModel>(onModelReady: (model) {
      model.getAllMarketStock();
    }, builder:
        (BuildContext context, MarketStockViewModel model, Widget? child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF2D365C),
            title: const Text(
              "Market",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: MarketStockWidget(
            data: model.marketData,
            state: model.state,
            localData: model.marketData!.data,
            errorMessage: model.errorMessage,
          ));
      /**/
    });
  }
}
