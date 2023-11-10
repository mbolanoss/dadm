class CustomMarker {
  late String name;
  late String address;
  late String type;
  late String iconography;
  late String ownerName;
  late String email;
  late double phoneNumber;
  late double latitude;
  late double longitude;

  CustomMarker({
    required this.name,
    required this.address,
    required this.type,
    required this.iconography,
    required this.ownerName,
    required this.email,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });

  CustomMarker.fromJson(Map<String, dynamic> json) {
    name = json['Nombre'];
    address = json['Direccion'] ?? "Sin dirección";
    type = json['Tipo_de_Pa'];
    iconography = json['Iconografi'];
    ownerName = json['Nombre_Pro'];
    email = json['Correo_Pro'] ?? 'Sin correo';
    phoneNumber = json['Telefono'];
    latitude = json['Latitud'];
    longitude = json['Longitud'];
  }
}
