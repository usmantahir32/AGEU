
import 'dart:convert';

AddOrderModel addOrderModelFromJson(String str) => AddOrderModel.fromJson(json.decode(str));

String addOrderModelToJson(AddOrderModel data) => json.encode(data.toJson());

class AddOrderModel {
    String subject;
    String cep;
    String deliveryDate;
    String deliveryperiod;
    String neighborhood;
    String city;
    String state;
    String publicPlace;
    List<Item> items;
    String numero;
    String complemento;

    AddOrderModel({
        required this.subject,
        required this.cep,
        required this.deliveryDate,
        required this.deliveryperiod,
        required this.neighborhood,
        required this.city,
        required this.state,
        required this.publicPlace,
        required this.items,
        required this.numero,
        required this.complemento,
    });

    factory AddOrderModel.fromJson(Map<String, dynamic> json) => AddOrderModel(
        subject: json["assunto"],
        cep: json["cep"],
        deliveryDate: json["dataDeEntrega"],
        deliveryperiod: json["periodoDeEntrega"],
        neighborhood: json["neighborhood"],
        city: json["city"],
        state: json["state"],
        publicPlace: json["publicPlace"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        numero: json["numero"],
        complemento: json["complemento"],
    );

    Map<String, dynamic> toJson() => {
        "assunto": subject,
        "cep": cep,
        "dataDeEntrega": deliveryDate,
        "periodoDeEntrega": deliveryperiod,
        "neighborhood": neighborhood,
        "city": city,
        "state": state,
        "publicPlace": publicPlace,
        "itens": List<dynamic>.from(items.map((x) => x.toJson())),
        "numero": numero,
        "complemento": complemento,
    };
}

class Item {
    String id;
    String anexo;
    String descricao;
    String quantidade;
    String tipoUnidade;

    Item({
        required this.id,
        required this.anexo,
        required this.descricao,
        required this.quantidade,
        required this.tipoUnidade,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        anexo: json["anexo"],
        descricao: json["descricao"],
        quantidade: json["quantidade"],
        tipoUnidade: json["tipoUnidade"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "anexo": anexo,
        "descricao": descricao,
        "quantidade": quantidade,
        "tipoUnidade": tipoUnidade,
    };
}
