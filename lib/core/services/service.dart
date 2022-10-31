import 'dart:convert';
import 'package:flutter_assessment/model/market_stock_model.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

class ServiceAPI {
  static const TAG = 'ECommerceAPI';
  static String endpoint ='api.marketstack.com';
  static String endpointType = debug ? 'open' : 'secure';
  static String authorityType = debug ? 'http' : "https";

   var client = new http.Client();
  Future<MarketStockModel> getAllMarketStock({String? access_key}) async {

    Map<String, String> queryParameters = {
      'access_key':"3d6feb1162648c7f986622a038e87a74",
      'date_from':'2022-10-21',
      'date_to':'2022-10-31'
    };

    Uri uri = Uri.http(endpoint, "/v1/tickers",queryParameters);
    final response = await client.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
      return  MarketStockModel.fromJson(json.decode(response.body));
    } else if (response.body != null) {
      throw Exception(response.body);
    } else {
      throw Exception('${response.toString()}');
    }
  }
  }