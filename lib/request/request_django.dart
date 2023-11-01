import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:precycler/model/model_UserData.dart';
import 'package:precycler/screen/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> login(BuildContext context, String id, String password, UserData? userData) async {
  final response = await http.post(
    Uri.parse('http://43.202.220.164:8000/login/'), // 실제 API 엔드포인트로 대체하세요
    body: {
      'mid': id,
      'password': password,
    },
  );
  if (response.statusCode == 200) {
    // 요청이 성공한 경우
    final responseData = json.decode(response.body);
    print("responseData : "+responseData);
    switch(responseData){
      case 'match':
        userData!.id = id;
        userData.password = password;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loginState', true);

        await prefs.setString('UserData_id',id);
        await prefs.setString('UserData_password',password);


        //현재 페이지 종료
        Navigator.pop(context);
        //홈 페이지로 전환
        Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen(userData: userData)));
        break;
      case 'mismatch':
        Fluttertoast.showToast(
          msg: "비밀번호가 올바르지 않습니다",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          fontSize: 15,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 'misid':
        Fluttertoast.showToast(
          msg: "아이디가 올바르지 않습니다",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          fontSize: 15,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
    }
  } else {
    Fluttertoast.showToast(
      msg: "네트워크 및 기타 오류",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey,
      fontSize: 15,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}