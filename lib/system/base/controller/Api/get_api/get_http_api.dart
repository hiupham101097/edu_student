// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'dart:io';

// import 'package:edu_student/system/_variables/value/app_const.dart';
// import 'package:http/http.dart' as http;

// class GetHttpApi {
//   GetHttpApi();

//   Future<http.Response> getProvinces(
//     String endpoint,
//     String baseUrl,
//     String? token,
//   ) async {
//     final uri = Uri.parse(baseUrl + endpoint).replace();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(uri, headers: headers);
//     return response;
//   }

//   Future<http.Response> getDataUrlNoQuery(
//     String endpoint,
//     String? token,
//   ) async {
//     final uri = Uri.parse('${AppConst.apiApth}/$endpoint').replace();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(uri, headers: headers);
//     return response;
//   }

//   Future<http.Response> getDataUrlQuery(
//     Map<String, dynamic> queryParams,
//     String? linkUrl,
//     String token,
//   ) async {
//     final url = Uri.https(
//       AppConst.uriApth,
//       '/${linkUrl ?? ''}',
//       queryParams.map((key, value) => MapEntry(key, value.toString())),
//     );

//     final headers = {
//       'Content-Type': 'application/json',
//       'accept': '*/*',
//       'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(url, headers: headers);

//     return response;
//   }

//   Future<http.Response> getDataUrlQueryTest(
//     Map<String, dynamic> queryParams,
//     String? linkUrl,
//     String token,
//   ) async {
//     final url = Uri.https(
//       AppConst.uriApth, // ✅ domain
//       '$linkUrl', // ✅ endpoint path
//       queryParams.map((k, v) => MapEntry(k, v.toString())), // ✅ query string
//     );

//     final headers = {
//       'Content-Type': 'application/json',
//       'accept': '*/*',
//       'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(url, headers: headers);

//     return response;
//   }

//   Future<http.Response> postDataUrl(
//     String? token,
//     Uri linkUrl,
//     Map<String, dynamic> data,
//   ) async {
//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     final body = jsonEncode(data);
//     final response = await http.post(linkUrl, headers: headers, body: body);
//     return response;
//   }

//   Future<http.Response> postUrl({
//     required String token,
//     required String linkUrl, // truyền vào đây cũng là room_id
//     required Map<String, dynamic> data,
//   }) async {
//     final uri = Uri.https(AppConst.uriApth, '/$linkUrl');

//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };

//     final body = jsonEncode(data);

//     final response = await http.post(uri, headers: headers, body: body);
//     return response;
//   }

//   Future<http.Response> putUrlData(
//     String? token,
//     Uri linkUrl,
//     Map<String, dynamic> data,
//   ) async {
//     // Tìm key có kiểu File trong data
//     final fileEntry = data.entries.firstWhere(
//       (entry) => entry.value is File,
//       orElse: () => throw Exception('No File found in data'),
//     );

//     final file = fileEntry.value as File;
//     final bytes = await file.readAsBytes();

//     var tpyeFile = file.path.substring(file.path.length - 3).toLowerCase();

//     final headers = <String, String>{'Content-Type': 'image/$tpyeFile'};

//     final response = await http.put(
//       linkUrl,
//       headers: headers,
//       body: bytes, // 👈 Gửi raw bytes của file
//     );

//     return response;
//   }

//   Future<http.Response> putFilesToUrl(
//     String? token,
//     Uri linkUrl,
//     List<File> files,
//   ) async {
//     http.Response? lastResponse;

//     for (final file in files) {
//       final bytes = await file.readAsBytes();
//       final extension = file.path.split('.').last.toLowerCase();
//       final headers = <String, String>{'Content-Type': 'image/$extension'};

//       final response = await http.put(linkUrl, headers: headers, body: bytes);

//       lastResponse = response;

//       // Nếu muốn dừng ngay khi có lỗi:
//       if (response.statusCode != 200) {
//         break;
//       }
//     }

//     // Trả về response cuối cùng (thành công hoặc lỗi)
//     return lastResponse ??
//         http.Response('No file uploaded', 400); // fallback nếu list rỗng
//   }

//   Future<http.Response> patchDataUrl({
//     required String token,
//     required String linkUrl, // truyền vào đây cũng là room_id
//     required Map<String, dynamic> data,
//   }) async {
//     final uri = Uri.https(AppConst.uriApth, '/$linkUrl');

//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };

//     final body = jsonEncode(data);

//     final response = await http.patch(uri, headers: headers, body: body);
//     return response;
//   }

//   Future<http.Response> patchRequestStatus({
//     required String token,
//     required String requestId,
//     required int status,
//     required String reason,
//     required String url,
//   }) async {
//     try {
//       var vlaue = status == 4 ? reason : null;
//       final response = await patchDataUrl(
//         token: token,
//         linkUrl: '$url/$requestId/status',
//         data: {"status": status, "reason": vlaue},
//       );

//       if (response.statusCode == 200) {
//         print("✅ Cập nhật trạng thái thành công");
//       } else {
//         print("❌ Thất bại: ${response.statusCode} - ${response.body}");
//       }

//       return response;
//     } catch (e) {
//       print("🔥 Exception khi gọi API: $e");
//       rethrow; // Hoặc return http.Response(...) lỗi tuỳ ý bạn
//     }
//   }

//   Future<http.Response> patchRequestMainStatus({
//     required String token,
//     required String requestId,
//     required int status,
//     required String reason,
//   }) async {
//     try {
//       final response = await patchDataUrl(
//         token: token,
//         linkUrl: 'request-maintenance/update-status/$requestId',
//         data: {"status": status, "note": reason},
//       );

//       if (response.statusCode == 200) {
//         print("✅ Cập nhật trạng thái thành công");
//       } else {
//         print("❌ Thất bại: ${response.statusCode} - ${response.body}");
//       }

//       return response;
//     } catch (e) {
//       print("🔥 Exception khi gọi API: $e");
//       rethrow; // Hoặc return http.Response(...) lỗi tuỳ ý bạn
//     }
//   }

//   Future<http.Response> getSSOUrl(String? linUrl, String queryParams) async {
//     final url = Uri.parse('${AppConst.apiSSO}/$linUrl');

//     final headers = {'Content-Type': 'application/json', 'accept': '*/*'};

//     final response = await http.post(url, headers: headers, body: queryParams);

//     return response;
//   }

//   Future<http.Response> getSSONoQuery(String endpoint, String? token) async {
//     final uri = Uri.parse('${AppConst.apiApth}/$endpoint').replace();

//     final headers = {
//       'Content-Type': 'application/json',
//       if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//     };

//     final response = await http.get(uri, headers: headers);
//     return response;
//   }
// }
