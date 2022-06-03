import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper_app/models/currency.dart';
import 'package:notekeeper_app/pages/add_currency_page.dart';

import 'currency_tile.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  bool _isLoading = false;
  String _response = "";
  List<CurrencyData> _currencies = [];

  @override
  void initState() {
    super.initState();
    _getCurrencies();
  }

  _getCurrencies() async {
    try {
      setState(() {
        _isLoading = true;
        _response = '';
      });
      String apiUrl =
          "https://api.vpay.smarttersstudio.in/v1/currency?\$limit=-1";
      var response = await Dio().get(apiUrl);
      _isLoading = false;
      _response = response.toString();
      _currencies = List<CurrencyData>.from(
          response.data.map((jsonObj) => CurrencyData.fromJson(jsonObj)));
      setState(() {});
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getCurrencies();
        },
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AddCurrencyPage()));
                },
                child: Text("Add a new currency")),
            _isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: GridView.builder(
                        itemCount: _currencies.length,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 11 / 9,
                                mainAxisSpacing: 16),
                        itemBuilder: (_, index) =>
                            CurrencyTile(_currencies[index])),
                  ),
          ],
        ),
      ),
    );
  }
}
