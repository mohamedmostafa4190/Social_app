class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? id;
  String? image;
  String? profileCover;
  String? bio;
  // bool? isEmailVerified;

  SocialUserModel({
    this.email,
    this.phone,
    this.name,
    this.id,
    this.image,
    this.profileCover,
    this.bio,
    // this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    bio = json['bio'];
    profileCover = json['profileCover'];
    // isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    data['image'] = image;
    data['profileCover'] = profileCover;
    data['bio'] = bio;
    // data['isEmailVerified'] = isEmailVerified;
    return data;
  }
}
