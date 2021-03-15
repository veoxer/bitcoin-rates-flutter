import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final String baseCoin;
  final String quoteCoin;
  final String rate;

  CoinCard({this.baseCoin, this.quoteCoin, this.rate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $baseCoin = $rate $quoteCoin',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
