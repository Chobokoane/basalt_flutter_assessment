import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment/model/market_stock_model.dart';
import 'package:flutter_assessment/core/enums/viewstate.dart';
import 'package:flutter_assessment/ui/view/results_view.dart';
import "dart:math";

import 'package:flutter_typeahead/flutter_typeahead.dart';

class MarketStockWidget extends StatefulWidget {
  final MarketStockModel? data;
  final List<Data>? localData;
  final ViewState? state;
  final String? errorMessage;
  const MarketStockWidget(
      {super.key, required this.data, required this.state, this.localData, required this.errorMessage});

  @override
  State<MarketStockWidget> createState() => _MarketStockWidgetState();
}

class _MarketStockWidgetState extends State<MarketStockWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController symbolsEditingController =
      TextEditingController();
  final TextEditingController countrytEditingController =
      TextEditingController();

      ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2D365C),
      child: Column(
        children: [
         _connectionStatus.toString() == "ConnectivityResult.none"? Center(
          child: Text('Connection Status: ${_connectionStatus.toString()}')):Container(),
          Container(
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Form(
              key: _formKey,
              child: TypeAheadFormField(
                suggestionsCallback: (pattern) => widget.localData!.where(
                  (item) =>
                      item.name.toLowerCase().contains(pattern.toLowerCase()),
                ),
                itemBuilder: (_, Data item) => ListTile(title: Text(item.name)),
                onSuggestionSelected: (Data val) {
                  textEditingController.text = val.name;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultsView(data: val)));
                },
                getImmediateSuggestions: true,
                hideSuggestionsOnKeyboardHide: false,
                hideOnEmpty: false,
                noItemsFoundBuilder: (context) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No Item Found"),
                ),
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: const InputDecoration(
                      hintText: 'Type your text here',
                      border: OutlineInputBorder()),
                  controller: textEditingController,
                ),
              ),
            ),
          ),
           widget.errorMessage != null
            ? Center(
                child: Text(
                  widget.errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              )
            : Container(),
          widget.state == ViewState.Busy
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final random = Random();
                      var element = widget.data!
                          .data![random.nextInt(widget.data!.data!.length)];
                      return Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          margin: const EdgeInsets.all(12),
                          height: 80,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          element.symbol ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          element.name,
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
                                      margin: const EdgeInsets.only(
                                          right: 12, bottom: 20),
                                      child: Text(
                                        element.stockExchange!.country ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ));
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
