import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  const TokenModel(
    this.accessToken, {
    this.expireInSeconds,
    this.encryptedAccessToken,
    this.tenantId,
    this.userId,
  });

  final String accessToken;
  final int? expireInSeconds;
  final String? encryptedAccessToken;
  final int? userId;
  final int? tenantId;


  factory TokenModel.fromJson(
    Map<String, dynamic> jsonInput,
  ) {
    return TokenModel(
      jsonInput["accessToken"],
      expireInSeconds: jsonInput["expireInSeconds"],
      encryptedAccessToken: jsonInput["encryptedAccessToken"],
      tenantId: jsonInput["tenantId"],
      userId: jsonInput["userId"],
    );
  }
  
  @override
  List<Object?> get props => [accessToken, expireInSeconds, encryptedAccessToken, userId, tenantId];
}
