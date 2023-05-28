class Admin{
  String id;
  String name;
  String? phone;

  Admin({
    required this.id,
    required this.name,
    this.phone
  });

  factory Admin.fromJson(Map<String,dynamic> json)=>Admin(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}