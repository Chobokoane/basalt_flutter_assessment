import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/viewmodel/market_stock_view_model.dart';
import 'package:flutter_assessment/core/model/market_stock_model.dart';
import 'package:flutter_assessment/ui/view/base_view.dart';
import 'package:flutter_assessment/ui/widget/results_widget.dart';

class ResultsView extends StatelessWidget {
  final Data data;
  const ResultsView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MarketStockViewModel>(onModelReady: (model) {
      model.getAllMarketStock();
    }, builder:
        (BuildContext context, MarketStockViewModel model, Widget? child) {
      return Scaffold(
        backgroundColor: const Color(0xFF2D365C),
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
          body: ResultsWidget(
            localData: data
          ));
      /**/
    });
  }
}
