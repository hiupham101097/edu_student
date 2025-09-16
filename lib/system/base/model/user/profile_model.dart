class ProfileModel {
  late int id;
  String? userName;
  String? name;
  String? surname;
  String? emailAddress;
  String? fullName;
  String? profile;
  String? contact;
  String? phoneNumber;
  String? address;

  ProfileModel(
    this.id, {
    this.fullName,
    this.emailAddress,
    this.profile,
    this.contact,
    this.name,
    this.surname,
    this.userName,
    this.address,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    // ignore: prefer_collection_literals, unnecessary_new
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["userName"] = userName;
    map["name"] = name;
    map["surname"] = surname;
    map["emailAddress"] = emailAddress;
    map["fullName"] = fullName;
    map["profile"] = profile;
    map["contact"] = contact;
    map["address"] = address;
    map["phoneNumber"] = phoneNumber;

    return map;
  }
}
