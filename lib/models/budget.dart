import 'dart:convert';

BudgetModel budgetModelFromJson(String str) =>
    BudgetModel.fromJson(json.decode(str));

String budgetModelToJson(BudgetModel data) => json.encode(data.toJson());

class BudgetModel {
  Data? data;
  List<dynamic>? errors;
  bool? success;

  BudgetModel({
    this.data,
    this.errors,
    this.success,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) => BudgetModel(
        data: Data.fromJson(json["data"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "errors": List<dynamic>.from(errors!.map((x) => x)),
        "success": success,
      };
}

class Data {
  String? assunto;
  List<BudgetData>? budgets;

  Data({
    this.assunto,
    this.budgets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        assunto: json["assunto"],
        budgets: List<BudgetData>.from(
            json["avaliacoes"].map((x) => BudgetData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "assunto": assunto,
        "avaliacoes": List<dynamic>.from(budgets!.map((x) => x.toJson())),
      };
}

class BudgetData {
  String? avaliacaoId;
  num? totalItens;
  num? totalItensAvaliado;
  bool? freteGratis;
  num? valorFrete;
  num? diasDeEntrega;
  Payment? payment;

  BudgetData({
    this.avaliacaoId,
    this.totalItens,
    this.totalItensAvaliado,
    this.freteGratis,
    this.valorFrete,
    this.diasDeEntrega,
    this.payment,
  });

  factory BudgetData.fromJson(Map<String, dynamic> json) => BudgetData(
        avaliacaoId: json["avaliacaoId"],
        totalItens: json["totalItens"],
        totalItensAvaliado: json["totalItensAvaliado"],
        freteGratis: json["freteGratis"],
        valorFrete: json["valorFrete"],
        diasDeEntrega: json["diasDeEntrega"],
        payment: Payment.fromJson(json["pagamento"]),
      );

  Map<String, dynamic> toJson() => {
        "avaliacaoId": avaliacaoId,
        "totalItens": totalItens,
        "totalItensAvaliado": totalItensAvaliado,
        "freteGratis": freteGratis,
        "valorFrete": valorFrete,
        "diasDeEntrega": diasDeEntrega,
        "pagamento": payment!.toJson(),
      };
}

class Payment {
  InstallMents? installments;
  AVista? aVista;

  Payment({
    this.installments,
    this.aVista,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        installments: InstallMents.fromJson(json["parcelado"]),
        aVista: AVista.fromJson(json["aVista"]),
      );

  Map<String, dynamic> toJson() => {
        "parcelado": installments!.toJson(),
        "aVista": aVista!.toJson(),
      };
}

class AVista {
  double? value;

  AVista({
    this.value,
  });

  factory AVista.fromJson(Map<String, dynamic> json) => AVista(
        value: json["valor"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "valor": value,
      };
}

class InstallMents {
  double? value;
  num? portion;

  InstallMents({
    this.value,
    this.portion,
  });

  factory InstallMents.fromJson(Map<String, dynamic> json) => InstallMents(
        value: json["valor"]?.toDouble(),
        portion: json["parcela"],
      );

  Map<String, dynamic> toJson() => {
        "valor": value,
        "parcela": portion,
      };
}
