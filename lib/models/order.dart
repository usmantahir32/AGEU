// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    List<OrderData>? data;
    List<dynamic>? errors;
    bool? success;

    OrderModel({
         this.data,
         this.errors,
         this.success,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        data: List<OrderData>.from(json["data"].map((x) => OrderData.fromJson(x))),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors!.map((x) => x)),
        "success": success,
    };
}

class OrderData {
    String? id;
    String? assunto;
    int? totalItems;
    Status? status;

    OrderData({
         this.id,
         this.assunto,
         this.totalItems,
         this.status,
    });

    factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        assunto: json["assunto"],
        totalItems: json["totalOrcamentos"],
        status: Status.fromJson(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "assunto": assunto,
        "totalOrcamentos": totalItems,
        "status": status!.toJson(),
    };
}

class Status {
    String? key;
    String? display;

    Status({
         this.key,
         this.display,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        key: json["key"],
        display: json["display"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "display": display,
    };
}
