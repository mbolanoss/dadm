enum CompanyType {
  // 1
  consultory,
  // 2
  dev,
  // 3
  factory,
}

String companyEnumToString(CompanyType type) {
  return type == CompanyType.consultory
      ? 'Consultoría'
      : type == CompanyType.dev
          ? 'Desarrollo a la medida'
          : 'Fábrica de software';
}

CompanyType stringToCompanyEnum(String type) {
  return type == 'Consultoría'
      ? CompanyType.consultory
      : type == 'Desarrollo a la medida'
          ? CompanyType.dev
          : CompanyType.factory;
}

class Company {
  int? id;
  late String name;
  late String url;
  late int phoneNumber;
  late String email;
  late String services;
  late CompanyType type;

  Company({
    required this.name,
    required this.url,
    required this.phoneNumber,
    required this.email,
    required this.services,
    required this.type,
  });

  Company.fromMap(Map<String, Object?> map) {
    name = map['name'] as String;
    url = map['url'] as String;
    phoneNumber = map['phoneNumber'] as int;
    email = map['email'] as String;
    services = map['services'] as String;
    type = stringToCompanyEnum(map['type'] as String);
    id = map['id'] as int;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'phoneNumber': phoneNumber,
      'email': email,
      'services': services,
      'type': companyEnumToString(type),
    };
  }

  @override
  String toString() {
    return '''
    -----------------------
    Nombre = $name
    Url = $url
    Tel = $phoneNumber
    Email = $email
    Servicios = $services
    Tipo = ${companyEnumToString(type)}
    -----------------------
''';
  }
}
