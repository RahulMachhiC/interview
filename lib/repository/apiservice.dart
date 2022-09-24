import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interview/models/CreatrUserResponse.dart';
import 'package:interview/models/EditResponse.dart';
import 'package:interview/models/userresponse.dart';

Future<UserResponse> fetchusers(int pagekey) async {
  var response = await http
      .get(Uri.parse("https://reqres.in/api/users?page=1&per_page=10"));
  print(response.body);
  if (response.statusCode == 200) {
    return UserResponse.fromJson(jsonDecode(response.body));
  } else {
    throw UnimplementedError();
  }
}

Future<CreateuserRespone> createuser(
    {required String username, required String job}) async {
  var body = {"name": username, "job": job};
  var response =
      await http.post(Uri.parse("https://reqres.in/api/users"), body: body);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 201) {
    return CreateuserRespone.fromJson(jsonDecode(response.body));
  } else {
    throw UnimplementedError();
  }
}

Future<EditResponse> edituser(
    {required String id, required String username, required String job}) async {
  var body = {"name": username, "job": job};

  var response =
      await http.put(Uri.parse("https://reqres.in/api/users/$id"), body: body);

  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return EditResponse.fromJson(jsonDecode(response.body));
  } else {
    throw UnimplementedError();
  }
}

Future deleteuser({required String id}) async {
  var response = await http.delete(
    Uri.parse("https://reqres.in/api/users/$id"),
  );
  if (response.statusCode == 204) {
  } else {
    throw UnimplementedError();
  }
}
