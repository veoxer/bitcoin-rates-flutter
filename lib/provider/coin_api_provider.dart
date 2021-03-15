import 'dart:convert';
import 'package:bitcoin_ticker/model/coin_api_model.dart';
import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:http/http.dart' as http;

class CoinApiProvider {
  String baseUrl;
  CoinApiProvider({this.baseUrl});

  Future<CoinApiModel> getExchangeRate(String base, String quote) async {
    CoinApiModel result;
    Uri url = Uri.https(
      baseUrl,
      '/v1/exchangerate/$base/$quote',
      {'apikey': kCoinApiKey},
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      result = CoinApiModel.fromJson(
        jsonDecode(response.body),
      );
    }
    return result;
  }
}
