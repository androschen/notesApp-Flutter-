import 'dart:ffi';

class UserModel {
  late String name, phone, email, password;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password});

  UserModel.fromJson(Map<String, dynamic> json) : this(
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
    password: json['password']
  );

  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    };
  }

}
