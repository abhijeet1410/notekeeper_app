import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper_app/pages/currency_page.dart';

class AddCurrencyPage extends StatefulWidget {
  const AddCurrencyPage({Key? key}) : super(key: key);

  @override
  State<AddCurrencyPage> createState() => _AddCurrencyPageState();
}

class _AddCurrencyPageState extends State<AddCurrencyPage> {
  late TextEditingController _currencyNameController,
      _currencyCodeController,
      _currencySymbolController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currencyNameController = TextEditingController();
    _currencyCodeController = TextEditingController();
    _currencySymbolController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _currencyNameController.dispose();
    _currencyCodeController.dispose();
    _currencySymbolController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _currencyNameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "Enter Currency Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  controller: _currencyCodeController,
                  decoration: InputDecoration(
                    hintText: "Enter Currency Code",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                  ),
                ),
              ),
              TextField(
                controller: _currencySymbolController,
                decoration: InputDecoration(
                  hintText: "Enter Currency Symbol",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent)),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        /// API CALL TO ADD CURRENCY
                        String _name = _currencyNameController.text.trim();
                        String _code = _currencyCodeController.text.trim();
                        String _symbol = _currencySymbolController.text.trim();
                        Map<String, dynamic> _body = {
                          "name": _name,
                          "code": _code,
                          "symbol": _symbol
                        };
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          String apiUrl =
                              "https://api.vpay.smarttersstudio.in/v1/currency?\$limit=-1";
                          Dio _dio = Dio();
                          var response = await _dio.post(apiUrl,
                              data: _body,
                              options: Options(headers: {
                                "Authorization":
                                    "eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2NTQxNzE0MDUsImV4cCI6MTY1Njc2MzQwNSwiYXVkIjoiaHR0cHM6Ly95b3VyZG9tYWluLmNvbSIsImlzcyI6ImZlYXRoZXJzIiwic3ViIjoiNjIxNDk5MWQ5ZGViZWUxZDA0ODY5OGI1IiwianRpIjoiMTk4MmVkNzItNTlhOC00M2RiLWE3NzctMjQwOWM4NzAxZmFiIn0.rhJ-ViXnVzuuxuHxLR4mmY6U-HrHul5DQ_MdL_-LGK4"
                              }));
                          _isLoading = false;
                          setState(() {});
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => CurrencyPage()));
                        } catch (e) {
                          setState(() => _isLoading = false);
                        }
                      },
                      child: Text("CREATE CURRENCY")),
            ],
          ),
        ),
      ),
    );
  }
}
