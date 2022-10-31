import 'package:flutter/material.dart';
import 'package:flutter_assessment/model/market_stock_model.dart';

class ResultsWidget extends StatelessWidget {
  final Data? localData;
  const ResultsWidget({super.key, this.localData});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        margin: const EdgeInsets.all(12),
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${localData!.symbol}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        localData!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 12, bottom: 20),
                    child: Text(
                      "${localData!.stockExchange!.country}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ))
              ],
            )
          ],
        ));
  }
}
