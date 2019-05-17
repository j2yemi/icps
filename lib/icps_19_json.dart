import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'UsersInfo.dart';


class icps_19_rest_api {

//  final String url = 'http://localhost:7101/icps/icps/19/urg';



  Future<dynamic> sendUsersInfo(String title, String username, String password,
      String firstname,
      String loginstatus, String surname, String email, String phone,
      String organisation, String companysector, String country) async {

    final String url = 'http://icps19.com:6060/icps/i/icps/19/urg';
    Response response;
    Dio dio = new Dio();
    response = await dio.post(url, queryParameters: {
      "title": title,
      "username": username,
      "password": password,
      "firstname": firstname,
      "loginstatus": loginstatus,
      "surname": surname,
      "email": email,
      "phone": phone,
      "organisation": organisation,
      "companysector": companysector,
      "country": country
    },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "accept": "application/json"
          },)
    );


    if (response.statusCode == 200) {
      //Donald Redirect to another page or show message...

    }
//    return true;
     return response;
//    Navigator.push (context,
//        MaterialPageRoute(builder: (context) => Homepage())
//    );
  }

  Future<dynamic> findUsersInfo(String username, String password)
  async {
    final String url = 'http://icps19.com:6060/icps/i/icps/19/urp';
    Response response;
    Dio dio = new Dio();
    response = await dio.get(url, queryParameters: {"username": username, "password": password});
    print(response.data.toString());
    //Donald bind the response data using the sample below
    print(UsersInfo.fromJson(response.data).surname);
    return response;
  }



}


