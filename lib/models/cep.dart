import 'dart:convert';

CepModel cepModelFromJson(String str) => CepModel.fromJson(json.decode(str));

String cepModelToJson(CepModel data) => json.encode(data.toJson());

class CepModel {
  CepModelData? data;
  bool? success;

  CepModel({
    this.data,
    this.success,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) => CepModel(
        data: json['success'] == true
            ? CepModelData.fromJson(json["data"])
            : null,
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "success": success,
      };
}

class CepModelData {
  City? city;
  State? state;
  double? altitude;
  double? latitude;
  double? longitude;
  String? neighborhood;
  String? cep;
  String? publicPlace;

  CepModelData({
    this.city,
    this.state,
    this.altitude,
    this.latitude,
    this.longitude,
    this.neighborhood,
    this.cep,
    this.publicPlace,
  });

  factory CepModelData.fromJson(Map<String, dynamic> json) => CepModelData(
        city: City.fromJson(json["cidade"]),
        state: State.fromJson(json["estado"]),
        altitude: json["altitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        neighborhood: json["bairro"],
        cep: json["cep"],
        publicPlace: json["logradouro"],
      );

  Map<String, dynamic> toJson() => {
        "cidade": city!.toJson(),
        "estado": state!.toJson(),
        "altitude": altitude,
        "latitude": latitude,
        "longitude": longitude,
        "bairro": neighborhood,
        "cep": cep,
        "logradouro": publicPlace,
      };
}

class City {
  String? ibge;
  String? nome;
  int? ddd;

  City({
    this.ibge,
    this.nome,
    this.ddd,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        ibge: json["ibge"],
        nome: json["nome"],
        ddd: json["ddd"],
      );

  Map<String, dynamic> toJson() => {
        "ibge": ibge,
        "nome": nome,
        "ddd": ddd,
      };
}

class State {
  String? sigla;

  State({
    this.sigla,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        sigla: json["sigla"],
      );

  Map<String, dynamic> toJson() => {
        "sigla": sigla,
      };
}
