import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment/core/model/market_stock_model.dart';
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
      {super.key,
      required this.data,
      required this.state,
      this.localData,
      required this.errorMessage});

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

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }
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
    return widget.errorMessage == "XMLHttpRequest error."
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 40,
                margin: const EdgeInsets.all(20),
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'You are not connected',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Form(
                  key: _formKey,
                  child: TypeAheadFormField(
                    suggestionsCallback: (pattern) => widget.localData!.where(
                      (item) => item.name!
                          .toLowerCase()
                          .contains(pattern.toLowerCase()),
                    ),
                    itemBuilder: (_, Data item) =>
                        ListTile(title: Text(item.name!)),
                    onSuggestionSelected: (Data val) {
                      textEditingController.text = val.name!;
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
            ],
          )
        : Container(
            color: const Color(0xFF2D365C),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                _connectionStatus.toString() == "ConnectivityResult.none"
                    ? Center(
                        child: Container(
                        width: 250,
                        height: 40,
                        margin: const EdgeInsets.all(20),
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            'You are not connected',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ))
                    : Container(),
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Form(
                    key: _formKey,
                    child: TypeAheadFormField(
                      suggestionsCallback: (pattern) => widget.localData!.where(
                        (item) => item.name!
                            .toLowerCase()
                            .contains(pattern.toLowerCase()),
                      ),
                      itemBuilder: (_, Data item) =>
                          ListTile(title: Text(item.name!)),
                      onSuggestionSelected: (Data val) {
                        textEditingController.text = val.name!;
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
                            var element = widget.data!.data![
                                random.nextInt(widget.data!.data!.length)];
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
                                                element.name!,
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
                                              element.stockExchange!.country ??
                                                  "",
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
