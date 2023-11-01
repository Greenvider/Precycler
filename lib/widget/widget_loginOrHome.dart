import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:precycler/screen/screen_login.dart';
import 'package:precycler/screen/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:precycler/model/model_UserData.dart';

class LoginOrHome extends StatefulWidget {
  //main.dart로부터 width, height 값을 받아오기
  double? width;
  double? height;
  LoginOrHome({super.key,this.width,this.height});

  @override
  State<LoginOrHome> createState() => _LoginOrHomeState();

}

class _LoginOrHomeState extends State<LoginOrHome> {
  //현재 로그인 상태
  bool loginState = false;

  //Safearea의 child가 될 위젯
  late Widget child;

  UserData userData = UserData(id: '',password: '',point: 0,name: '');

  bool loding = true;

  Future<void> i() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? login_state = prefs.getBool('loginState');

    setState(() {
      loginState = (login_state != null)?true:false;
    });

    //만약 현재 로그인 되지 않았다면
    if(!loginState){
      //로그인 스크린을 띄우기
      setState(() {
        child = LoginScreen();
        loding = false;
      });
    }
    //만약 로그인이 되었다면
    else{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {

        final String? user_data_id = prefs.getString('UserData_id');
        final String? user_data_password = prefs.getString('UserData_password');

        print(user_data_id!+" "+user_data_password!);

        userData.id = user_data_id;
        userData.password = user_data_password;


        child = HomeScreen(userData: userData,);
        loding = false;
      });
      //Home위젯 보이기
    }
  }

  //HomeScreen위젯 상태 초기화, 즉 HomeScreen위젯이 불러와지고 호출됨
  void initState() {
    //MyApp위젯에서 가져온 width, height값 저장
    double? width = widget.width;
    double? height = widget.height;

    //스플레쉬 화면 종료하기
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    i();
    //print("   " +loding.toString());
    if(loding){
      return SafeArea(child: Scaffold(backgroundColor: Colors.black,body: Center(child: CircularProgressIndicator(),),));
    }
    else{
      return SafeArea(child: child);
    }
  }
}
