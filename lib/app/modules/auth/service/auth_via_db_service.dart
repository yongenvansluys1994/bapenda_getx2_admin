// ignore_for_file: depend_on_referenced_packages, unused_import, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:bapenda_getx2_admin/app/modules/auth/dto/auth_via_keycloak_dto.dart';
import 'package:bapenda_getx2_admin/app/modules/auth/service/auth_cache_service.dart';
import 'package:bapenda_getx2_admin/utils/app_const.dart';
import 'package:bapenda_getx2_admin/widgets/snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthViaDBService with AuthCacheService {
  Future login(String username, String password) async {
    try {
      Map<String, String> bodyData = {
        'nik': username,
        'password': password,
      };

      return await _loginProses(bodyData);
    } catch (err) {
      RawSnackbar_top(message: "${err}", kategori: "error", duration: 2);
      EasyLoading.dismiss();
    }
  }

  // Future refreshToken() async {
  //   try {
  //     String _refreshToken = getRefreshToken()!;

  //     Map<String, String> bodyData = {
  //       'client_id': KEYCLOAK_CLIENT_ID,
  //       'grant_type': GRANT_TYPE_REFRESH_TOKEN,
  //       'refresh_token': _refreshToken,
  //     };
  //     return await _getToken(bodyData);
  //     //return await _getToken(bodyData);
  //   } catch (err) {
  //     throw Exception(err);
  //   }
  // }

  Future<void> logout() async {}

  // Future _getToken(Map<String, String> data) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cache-Control': 'no-cache'
  //   };

  //   http.Response response = await http.post(
  //     Uri.parse(KEYCLOAK_HOST_URL),
  //     headers: headers,
  //     body: data,
  //   );

  //   if (response.statusCode == 200) {
  //     final dynamic token = json.decode(response.body);

  //     return _authViaKeycloakDto;
  //   } else if (response.statusCode == 401) {
  //     return throw ("Incorrect ID Number or Password");
  //   } else if (response.statusCode == 400) {
  //     return throw ("Something wrong, please check Form");
  //   } else {
  //     throw ("Server error");
  //   }
  // }

  Future _loginProses(Map<String, String> data) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cache-Control': 'no-cache'
    };

    http.Response response = await http
        .post(
          Uri.parse(YONGENBISA_HOST_URL), //gmf pakai KEYCLOAK_HOST_URL
          headers: headers,
          body: data,
        )
        .timeout(Duration(seconds: 10));
    final dynamic datauser = json.decode(response.body);

    print("asdasda:${datauser}");
    if (response.statusCode == 200 && datauser['success'] == true) {
      //AuthViaKeycloakDto _authViaKeycloakDto =
      //AuthViaKeycloakDto.fromJson(token);

      return datauser;
    } else if (datauser['success'] == false) {
      return throw ("Incorrect ID Number or Password");
    } else if (response.statusCode == 400) {
      return throw ("Something wrong, please check Form");
    } else {
      throw ("Server error");
    }
  }
}
