// To parse this JSON data, do
//
//     final currencyData = currencyDataFromJson(jsonString);

import 'dart:convert';

CurrencyData currencyDataFromJson(String str) => CurrencyData.fromJson(json.decode(str));

String currencyDataToJson(CurrencyData data) => json.encode(data.toJson());

class CurrencyData {
  CurrencyData({
    this.id,
    this.createdBy,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.updatedBy,
    this.symbol,
  });

  String? id;
  String? createdBy;
  String? name;
  String? code;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? updatedBy;
  String? symbol;

  factory CurrencyData.fromJson(Map<String, dynamic> json) => CurrencyData(
    id: json["_id"],
    createdBy: json["createdBy"],
    name: json["name"],
    code: json["code"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    updatedBy: json["updatedBy"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdBy": createdBy,
    "name": name,
    "code": code,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "__v": v,
    "updatedBy": updatedBy,
    "symbol": symbol,
  };
}
