// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String aO;
  String trimestre;
  Proveedor proveedor;
  Segmento segmento;
  Terminal terminal;
  TecnologA tecnologA;
  String noSuscriptores;

  Welcome({
    required this.aO,
    required this.trimestre,
    required this.proveedor,
    required this.segmento,
    required this.terminal,
    required this.tecnologA,
    required this.noSuscriptores,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        aO: json["a_o"],
        trimestre: json["trimestre"],
        proveedor: proveedorValues.map[json["proveedor"]]!,
        segmento: segmentoValues.map[json["segmento"]]!,
        terminal: terminalValues.map[json["terminal"]]!,
        tecnologA: tecnologAValues.map[json["tecnolog_a"]]!,
        noSuscriptores: json["no_suscriptores"],
      );

  Map<String, dynamic> toJson() => {
        "a_o": aO,
        "trimestre": trimestre,
        "proveedor": proveedorValues.reverse[proveedor],
        "segmento": segmentoValues.reverse[segmento],
        "terminal": terminalValues.reverse[terminal],
        "tecnolog_a": tecnologAValues.reverse[tecnologA],
        "no_suscriptores": noSuscriptores,
      };
}

enum Proveedor {
  AVANTEL_S_A_S,
  COLOMBIA_MOVIL_S_A_ESP,
  COLOMBIA_TELECOMUNICACIONES_S_A_E_S_P,
  COMUNICACION_CELULAR_S_A_COMCEL_S_A,
  EMPRESA_DE_TELECOMUNICACIONES_DE_BOGOTA_S_A_ESP,
  INTELNEXT_SAS,
  PARTNERS_TELECOM_COLOMBIA_SAS,
  SETROC_MOBILE_GROUP_SAS,
  VIRGIN_MOBILE_COLOMBIA_S_A_S
}

final proveedorValues = EnumValues({
  "AVANTEL S.A.S": Proveedor.AVANTEL_S_A_S,
  "COLOMBIA MOVIL  S.A ESP": Proveedor.COLOMBIA_MOVIL_S_A_ESP,
  "COLOMBIA TELECOMUNICACIONES S.A. E.S.P.":
      Proveedor.COLOMBIA_TELECOMUNICACIONES_S_A_E_S_P,
  "COMUNICACION CELULAR S A COMCEL S A":
      Proveedor.COMUNICACION_CELULAR_S_A_COMCEL_S_A,
  "EMPRESA DE TELECOMUNICACIONES DE BOGOTA S.A. ESP":
      Proveedor.EMPRESA_DE_TELECOMUNICACIONES_DE_BOGOTA_S_A_ESP,
  "INTELNEXT SAS": Proveedor.INTELNEXT_SAS,
  "PARTNERS TELECOM COLOMBIA SAS": Proveedor.PARTNERS_TELECOM_COLOMBIA_SAS,
  "SETROC MOBILE GROUP SAS": Proveedor.SETROC_MOBILE_GROUP_SAS,
  "VIRGIN MOBILE COLOMBIA S.A.S.": Proveedor.VIRGIN_MOBILE_COLOMBIA_S_A_S
});

enum Segmento { EMPRESAS, PERSONAS }

final segmentoValues =
    EnumValues({"Empresas": Segmento.EMPRESAS, "Personas": Segmento.PERSONAS});

enum TecnologA { CMTS_PARA_REDES_CON_TECNOLOG, THE_2_G, THE_3_G, THE_4_G }

final tecnologAValues = EnumValues({
  "CMTS (para redes con tecnolog�": TecnologA.CMTS_PARA_REDES_CON_TECNOLOG,
  "2G": TecnologA.THE_2_G,
  "3G": TecnologA.THE_3_G,
  "4G": TecnologA.THE_4_G
});

enum Terminal { DATA_CARD, TEL_FONO_M_VIL }

final terminalValues = EnumValues({
  "Data Card": Terminal.DATA_CARD,
  "Tel�fono m�vil": Terminal.TEL_FONO_M_VIL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
