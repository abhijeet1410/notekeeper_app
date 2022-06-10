import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:notekeeper_app/models/currency.dart';
import 'package:notekeeper_app/pages/currency_page.dart';

class CurrencyController extends GetxController
    with StateMixin<List<CurrencyData>> {
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getCurrencies();
  }

  Future<void> getCurrencies() async {
    try {
      change(null, status: RxStatus.loading());
      String apiUrl =
          "https://api.vpay.smarttersstudio.in/v1/currency?\$limit=-1";
      var response = await Dio().get(apiUrl);
      var _currencies = List<CurrencyData>.from(
          response.data.map((jsonObj) => CurrencyData.fromJson(jsonObj)));
      if(_currencies.isEmpty){
        change([], status: RxStatus.empty());
      } else {
        change(_currencies, status: RxStatus.success());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addCurrency(String name, String code, String symbol) async {
    isLoading.value = true;
    Map<String, dynamic> _body = {
      "name": name,
      "code": code,
      "symbol": symbol
    };
    try {
      // String apiUrl =
      //     "https://api.vpay.smarttersstudio.in/v1/currency?\$limit=-1";
      // Dio _dio = Dio();
      // var response = await _dio.post(apiUrl,
      //     data: _body,
      //     options: Options(headers: {
      //       "Authorization":
      //       "eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2NTQxNzE0MDUsImV4cCI6MTY1Njc2MzQwNSwiYXVkIjoiaHR0cHM6Ly95b3VyZG9tYWluLmNvbSIsImlzcyI6ImZlYXRoZXJzIiwic3ViIjoiNjIxNDk5MWQ5ZGViZWUxZDA0ODY5OGI1IiwianRpIjoiMTk4MmVkNzItNTlhOC00M2RiLWE3NzctMjQwOWM4NzAxZmFiIn0.rhJ-ViXnVzuuxuHxLR4mmY6U-HrHul5DQ_MdL_-LGK4"
      //     }));
      Future.delayed(const Duration(seconds: 3)).then((value){
        isLoading.value = false;
        Get.to(() => const CurrencyPage());
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
