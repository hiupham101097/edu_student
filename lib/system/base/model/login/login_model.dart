import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class LoginModel extends Equatable{
  String? userName;
  String? password;
  String? status;

  LoginModel({
    this.userName,
    this.password,
    this.status,
  }); 

  LoginModel.instance();

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_new, prefer_collection_literals
    var map = new Map<String, dynamic>();
    map["userNameOrEmailAddress"] = userName != null ? userName!.trim() : "";
    map["password"] = password != null ? password!.trim() : "";

    return map;
  }

  LoginModel coppyWith({
    String? userName,
    String? passWord
  }){
    return LoginModel();
  }

  @override
  List<Object?> get props => [userName,password];
}

