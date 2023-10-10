
import 'dart:convert';

BudgetDetailModel budgetDetailModelFromJson(String? str) => BudgetDetailModel.fromJson(json.decode(str!));

String? budgetDetailModelToJson(BudgetDetailModel data) => json.encode(data.toJson());

class BudgetDetailModel {
    Data? data;
    List<dynamic>? errors;
    bool? success;

    BudgetDetailModel({
         this.data,
         this.errors,
         this.success,
    });

    factory BudgetDetailModel.fromJson(Map<String?, dynamic> json) => BudgetDetailModel(
        data: Data.fromJson(json["data"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        success: json["success"],
    );

    Map<String?, dynamic> toJson() => {
        "data": data!.toJson(),
        "errors": List<dynamic>.from(errors!.map((x) => x)),
        "success": success,
    };
}

class Data {
    String? subject;
    Endereco? address;
    BudgetPayment? payment;

    Data({
         this.subject,
         this.address,
         this.payment,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        subject: json["assunto"],
        address: Endereco.fromJson(json["endereco"]),
        payment: BudgetPayment.fromJson(json["pagamento"]),
    );

    Map<String, dynamic> toJson() => {
        "assunto": subject,
        "endereco": address!.toJson(),
        "pagamento": payment!.toJson(),
    };
}

class Endereco {
    String? cep;
    String? state;
    String? city;
    String? neighborhood;
    String? publicPlace;
    String? complemento;
    String? numero;

    Endereco({
         this.cep,
         this.state,
         this.city,
         this.neighborhood,
         this.publicPlace,
         this.complemento,
         this.numero,
    });

    factory Endereco.fromJson(Map<String?, dynamic> json) => Endereco(
        cep: json["cep"],
        state: json["estado"],
        city: json["cidade"],
        neighborhood: json["bairro"],
        publicPlace: json["logradouro"],
        complemento: json["complemento"],
        numero: json["numero"],
    );

    Map<String?, dynamic> toJson() => {
        "cep": cep,
        "estado": state,
        "cidade": city,
        "bairro": neighborhood,
        "logradouro": publicPlace,
        "complemento": complemento,
        "numero": numero,
    };
}

class BudgetPayment {
    BudgetInstallments? installments;
    AVista? aVista;

    BudgetPayment({
         this.installments,
         this.aVista,
    });

    factory BudgetPayment.fromJson(Map<String?, dynamic> json) => BudgetPayment(
        installments: BudgetInstallments.fromJson(json["parcelado"]),
        aVista: AVista.fromJson(json["aVista"]),
    );

    Map<String?, dynamic> toJson() => {
        "parcelado": installments!.toJson(),
        "aVista": aVista!.toJson(),
    };
}

class AVista {
    int? desconto;
    double? valor;

    AVista({
         this.desconto,
         this.valor,
    });

    factory AVista.fromJson(Map<String?, dynamic> json) => AVista(
        desconto: json["desconto"],
        valor: json["valor"]?.toDouble(),
    );

    Map<String?, dynamic> toJson() => {
        "desconto": desconto,
        "valor": valor,
    };
}

class BudgetInstallments {
    double? valor;
    int? portion;
    double? total;

    BudgetInstallments({
         this.valor,
         this.portion,
         this.total,
    });

    factory BudgetInstallments.fromJson(Map<String?, dynamic> json) => BudgetInstallments(
        valor: json["valor"]?.toDouble(),
        portion: json["parcela"],
        total: json["total"]?.toDouble(),
    );

    Map<String?, dynamic> toJson() => {
        "valor": valor,
        "parcela": portion,
        "total": total,
    };
}
