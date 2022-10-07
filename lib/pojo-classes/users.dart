class Users {
  String id;
  String name;
  String phone;
  String image;
  int createdOn;

  Users({this.id, this.name, this.phone, this.image, this.createdOn});

  Users.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        phone = snapshot['phone'] ?? '',
        image = snapshot['image'] ?? '',
        createdOn = snapshot['createdOn'] ?? 0;

  toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "image": image,
      "createdOn": createdOn,
    };
  }
}
