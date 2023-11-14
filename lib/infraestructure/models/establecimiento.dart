class Establecimiento {
  int id;
  String name;
  String direccion;
  String phone;
  int user;

  Establecimiento({
    required this.id,
    required this.name,
    required this.direccion,
    required this.phone,
    required this.user,
  });

  factory Establecimiento.fromJson(Map<String, dynamic> json) =>
      Establecimiento(
        id: json["id"],
        name: json["name"],
        direccion: json["direccion"],
        phone: json["phone"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "direccion": direccion,
        "phone": phone,
        "user": user,
      };
}
