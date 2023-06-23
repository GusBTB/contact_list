class UserReturnModel {
  String? username;
  String? password;
  String? email;
  String? address;

  UserReturnModel({this.username, this.password, this.email, this.address});

  UserReturnModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['address'] = address;
    return data;
  }
}
