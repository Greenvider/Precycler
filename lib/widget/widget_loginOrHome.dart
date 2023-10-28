import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:precycler/screen/screen_login.dart';
import 'package:precycler/screen/screen_home.dart';

class LoginOrHome extends StatefulWidget {
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

  //HomeScreen위젯 상태 초기화, 즉 HomeScreen위젯이 불러와지고 호출됨
  void initState() {
    //MyApp위젯에서 가져온 width, height값 저장
    double? width = widget.width;
    double? height = widget.height;

    //스플레쉬 화면 종료하기
    FlutterNativeSplash.remove();

    //만약 현재 로그인 되지 않았다면
    if(!loginState){
      //로그인 스크린을 띄우기
      child = LoginScreen(width: width, height: height);
    }
    //만약 로그인이 되었다면
    else{
      //Home위젯 보이기
      child = HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    //상태표지줄과 네비게이션 바와 겹치지 않는 안전한 영역을 반환
    return SafeArea(
        //자식은 앞에서 지정한 로그인 화면 또는 홈화면으로 지정
        child: child,
    );
  }
}
