// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

CartaModel cartaModelFromJson(String str) =>
    CartaModel.fromJson(json.decode(str));

String cartaModelToJson(CartaModel data) => json.encode(data.toJson());

class CartaModel {
  int id = 0;
  String caminoVida = '';
  String caminoAlma = '';
  String personalidad = '';
  String temperamento = '';
  String mision = '';
  String metaFinal = '';
  String compatibilidadPareja = '';
  String fechaNacimiento = '';
  String nombre = '';
  String sumatoriaVocal = '';
  String sumatoriaConsonante = '';
  String nacimiento = '';

  CartaModel({
    this.id = 0,
    this.nacimiento = '',
    this.caminoVida = '',
    this.caminoAlma = '',
    this.personalidad = '',
    this.temperamento = '',
    this.mision = '',
    this.metaFinal = '',
    this.compatibilidadPareja = '',
    this.fechaNacimiento = '',
    this.nombre = '',
    this.sumatoriaVocal = '',
    this.sumatoriaConsonante = '',
  });

  factory CartaModel.fromJson(Map<String, dynamic> json) => new CartaModel(
        id: json["id"],
        caminoVida: json["caminoVida"],
        nacimiento: json["nacimiento"],
        caminoAlma: json["caminoAlma"],
        personalidad: json["personalidad"],
        temperamento: json["temperamento"],
        mision: json["mision"],
        metaFinal: json["metaFinal"],
        compatibilidadPareja: json["compatibilidadPareja"],
        fechaNacimiento: json["fechaNacimiento"],
        nombre: json["nombre"],
        sumatoriaVocal: json["sumatoriaVocal"],
        sumatoriaConsonante: json["sumatoriaConsonante"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "caminoVida": caminoVida,
        "nacimiento": nacimiento,
        "caminoAlma": caminoAlma,
        "personalidad": personalidad,
        "temperamento": temperamento,
        "mision": mision,
        "metaFinal": metaFinal,
        "compatibilidadPareja": compatibilidadPareja,
        "fechaNacimiento": fechaNacimiento,
        "nombre": nombre,
        "sumatoriaVocal": sumatoriaVocal,
        "sumatoriaConsonante": sumatoriaConsonante,
      };

  String toString() {
    return this.id.toString() +
        ' ' +
        this.caminoVida +
        ' ' +
        this.nacimiento +
        ' ' +
        this.caminoAlma +
        ' ' +
        this.personalidad +
        ' ' +
        this.temperamento +
        ' ' +
        this.mision +
        ' ' +
        this.metaFinal +
        ' ' +
        this.compatibilidadPareja +
        ' ' +
        this.fechaNacimiento +
        ' ' +
        this.nombre +
        ' ' +
        this.sumatoriaVocal.toString() +
        ' ' +
        this.sumatoriaConsonante.toString();
  }
}
