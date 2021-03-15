import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/components/coin_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  Map<String, String> rates = {};

  DropdownButton getAndroidDropDownBtn() {
    List<DropdownMenuItem> currencies = [];
    for (String cur in currenciesList) {
      currencies.add(
        DropdownMenuItem(
          child: Text(cur),
          value: cur,
        ),
      );
    }

    return DropdownButton(
      value: selectedCurrency,
      items: currencies,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          updateRates();
        });
      },
    );
  }

  CupertinoPicker getiOSPicker() {
    List<Text> currencies = [];

    for (String cur in currenciesList) {
      currencies.add(Text(cur));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          updateRates();
        });
      },
      children: currencies,
    );
  }

  Future updateRates() async {
    EasyLoading.show(status: 'loading...');
    try {
      Map<String, String> data = await coinData.getCoinData(selectedCurrency);
      EasyLoading.dismiss();
      setState(() {
        rates = data;
      });
    } catch (e) {
      print(e);
    }
  }

  List<CoinCard> baseCoinsCards() {
    List<CoinCard> coinCards = [];
    for (String base in cryptoList) {
      coinCards.add(
        CoinCard(
          baseCoin: base,
          quoteCoin: selectedCurrency,
          rate: rates[base],
        ),
      );
    }
    return coinCards;
  }

  @override
  void initState() {
    super.initState();
    updateRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                children: baseCoinsCards(),
              )),
          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 25.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getiOSPicker() : getAndroidDropDownBtn(),
          ),
        ],
      ),
    );
  }
}
