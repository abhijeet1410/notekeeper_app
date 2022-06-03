import 'package:flutter/material.dart';
import 'package:notekeeper_app/models/currency.dart';

class CurrencyTile extends StatelessWidget {
  final CurrencyData currency;

  const CurrencyTile(this.currency, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currency.symbol!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 64),
          ),
          Text(
            currency.code!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      )),
    );
  }
}
