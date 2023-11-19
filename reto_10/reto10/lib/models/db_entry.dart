// ignore_for_file: constant_identifier_names

class DBEntry {
  String year;
  String trimester;
  Supplier provider;
  Segment segment;
  Terminal terminal;
  Technology technology;
  String noSuscriptors;

  DBEntry({
    required this.year,
    required this.trimester,
    required this.provider,
    required this.segment,
    required this.terminal,
    required this.technology,
    required this.noSuscriptors,
  });

  factory DBEntry.fromJson(Map<String, dynamic> json) => DBEntry(
        year: json["a_o"],
        trimester: json["trimestre"],
        provider: supplierValues.map[json["proveedor"]]!,
        segment: segmentValues.map[json["segmento"]]!,
        terminal: terminalValues.map[json["terminal"]]!,
        technology: technologyValues.map[json["tecnolog_a"]]!,
        noSuscriptors: json["no_suscriptores"],
      );

  Map<String, dynamic> toJson() => {
        "a_o": year,
        "trimestre": trimester,
        "proveedor": supplierValues.reverse[provider],
        "segmento": segmentValues.reverse[segment],
        "terminal": terminalValues.reverse[terminal],
        "tecnolog_a": technologyValues.reverse[technology],
        "no_suscriptores": noSuscriptors,
      };
}

enum Supplier {
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

final List<Supplier> validSuppliers = [
  Supplier.AVANTEL_S_A_S,
  Supplier.COLOMBIA_MOVIL_S_A_ESP,
  Supplier.COLOMBIA_TELECOMUNICACIONES_S_A_E_S_P,
  Supplier.COMUNICACION_CELULAR_S_A_COMCEL_S_A,
  Supplier.EMPRESA_DE_TELECOMUNICACIONES_DE_BOGOTA_S_A_ESP,
  Supplier.PARTNERS_TELECOM_COLOMBIA_SAS,
  Supplier.VIRGIN_MOBILE_COLOMBIA_S_A_S
];

final supplierValues = EnumValues({
  "AVANTEL S.A.S": Supplier.AVANTEL_S_A_S,
  "COLOMBIA MOVIL  S.A ESP": Supplier.COLOMBIA_MOVIL_S_A_ESP,
  "COLOMBIA TELECOMUNICACIONES S.A. E.S.P.":
      Supplier.COLOMBIA_TELECOMUNICACIONES_S_A_E_S_P,
  "COMUNICACION CELULAR S A COMCEL S A":
      Supplier.COMUNICACION_CELULAR_S_A_COMCEL_S_A,
  "EMPRESA DE TELECOMUNICACIONES DE BOGOTA S.A. ESP":
      Supplier.EMPRESA_DE_TELECOMUNICACIONES_DE_BOGOTA_S_A_ESP,
  "INTELNEXT SAS": Supplier.INTELNEXT_SAS,
  "PARTNERS TELECOM COLOMBIA SAS": Supplier.PARTNERS_TELECOM_COLOMBIA_SAS,
  "SETROC MOBILE GROUP SAS": Supplier.SETROC_MOBILE_GROUP_SAS,
  "VIRGIN MOBILE COLOMBIA S.A.S.": Supplier.VIRGIN_MOBILE_COLOMBIA_S_A_S
});

enum Segment { EMPRESAS, PERSONAS }

final segmentValues =
    EnumValues({"Empresas": Segment.EMPRESAS, "Personas": Segment.PERSONAS});

enum Technology { CMTS_PARA_REDES_CON_TECNOLOG, THE_2_G, THE_3_G, THE_4_G }

final technologyValues = EnumValues({
  "CMTS (para redes con tecnolog�": Technology.CMTS_PARA_REDES_CON_TECNOLOG,
  "2G": Technology.THE_2_G,
  "3G": Technology.THE_3_G,
  "4G": Technology.THE_4_G
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
