import 'package:flutter/material.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/ui/view/market_stock_view.dart';
final debug = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String? prodId;

  const MyApp({Key? key, this.prodId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Assessment',
        home: MarketStockyView());
  }
}
