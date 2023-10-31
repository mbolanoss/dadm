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

class Company {
  String name;
  String url;
  int phoneNumber;
  String email;
  String services;
  CompanyType type;

  Company({
    required this.name,
    required this.url,
    required this.phoneNumber,
    required this.email,
    required this.services,
    required this.type,
  });

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
}
