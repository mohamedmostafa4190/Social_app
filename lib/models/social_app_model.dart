class UserCreateModel {
  String? name;
  String? email;
  String? phone;
  String? uId;

  UserCreateModel({this.email, this.phone, this.name, this.uId});

  UserCreateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['uId'] = uId;
    return data;
  }
}
