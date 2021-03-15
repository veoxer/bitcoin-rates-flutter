class CoinApiModel {
  DateTime time;
  String baseCurrency;
  String quoteCurrency;
  String rate;

  CoinApiModel({this.time, this.baseCurrency, this.quoteCurrency, this.rate});

  CoinApiModel.fromJson(Map<String, dynamic> json)
      : time = DateTime.parse(json['time']),
        baseCurrency = json['asset_id_base'],
        quoteCurrency = json['asset_id_quote'],
        rate = ((json['rate'] as double).toStringAsFixed(0)).toString();
}
