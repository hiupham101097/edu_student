// ignore_for_file: file_names

import '../../../../main.dart';
import '../../../_variables/storage/global_params.dart';

class SetToken {
  Future<TokenAuth> setToken() async {
    token = await GlobalParams.getAuthToken();
    var enc = GlobalParams.getEncryptedToken();

    var setData = TokenAuth(token: "", encAuthToken: "", tenant: "");

    setData.token = Uri.encodeComponent(token!.replaceAll("Bearer", "").trim());
    setData.tenant = GlobalParams.getUserData()!.tenant!.id.toString();
    setData.encAuthToken = Uri.encodeComponent(enc!.trim());

    return setData;
  }
}

class TokenAuth {
  String token;
  String encAuthToken;
  String tenant;

  TokenAuth({
    required this.token,
    required this.encAuthToken,
    required this.tenant,
  });
}
