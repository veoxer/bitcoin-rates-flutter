import 'package:bitcoin_ticker/model/coin_api_model.dart';
import 'package:bitcoin_ticker/provider/coin_api_provider.dart';
import 'package:bitcoin_ticker/utilities/constants.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MAD',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinApiProvider provider = CoinApiProvider(baseUrl: kCoinApiUrl);
  Future<Map<String, String>> getCoinData(String quote) async {
    Map<String, String> rates = {};
    for (String base in cryptoList) {
      CoinApiModel model = await provider.getExchangeRate(base, quote);
      rates[base] = model != null ? model.rate : '?';
    }
    return rates;
  }
}
