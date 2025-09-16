// import 'dart:convert';

// import 'package:edu_student/system/_variables/http/app_http_model.dart';
// import 'package:edu_student/system/base/controller/Api/get_api/get_http_api.dart';
// import 'package:edu_student/system/base/model/city/city_model.dart';
// import 'package:http/http.dart' as http;

// class ProvincesBaseApi {
//   ProvincesBaseApi();

//   Future<AppHttpModel<List<CityModel>>> getECity() async {
//     // Gọi API với query params
//     final response = await GetHttpApi().getProvinces(
//       "provinces?page=0&size=1000&query=",
//       "https://open.oapi.vn/location/",
//       null,
//     );

//     var content = json.decode(response.body);

//     if (response.statusCode == 200) {
//       List<CityModel> items =
//           (content['data'] as Iterable)
//               .map((e) => CityModel.fromJson(e))
//               .toList();
//       var result = AppHttpModel<List<CityModel>>(items);
//       return result;
//     } else {
//       return AppHttpModel.getError<List<CityModel>>(response.body);
//     }
//   }

//   Future<AppHttpModel<List<CityModel>>> fetchProvinceDetail() async {
//     const baseUrl = 'https://provinces.open-api.vn';
//     const endpoint = '/api/p'; // province_code = 1 (Hà Nội)

//     final uri = Uri.parse(
//       '$baseUrl$endpoint',
//     ); // Không cần .replace() nếu không có query manipulation

//     final headers = {
//       'Content-Type': 'application/json',
//       // Không cần Authorization vì API này không yêu cầu token
//       // Nếu có: 'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(uri, headers: headers);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       List<CityModel> items =
//           (data as Iterable).map((e) => CityModel.fromJson(e)).toList();
//       var result = AppHttpModel<List<CityModel>>(items);
//       return result;
//     } else {
//       return AppHttpModel.getError<List<CityModel>>(response.body);
//     }
//   }
// }
