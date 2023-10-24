import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screen_login.dart';

class HomeScreen extends StatefulWidget {
  double? width;
  double? height;

  HomeScreen({super.key,this.width,this.height});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    //나중에 django에서 다양한 정보를 불러와 저장


    //만약 현재 로그인 되지 않았다면
    if(!loginState){
      //로그인 스크린들 띄우기
      child = LoginScreen(width: width, height: height);
    }
    //만약 로그인이 되었다면
    else{
      //Home위젯 보이기
      child = Home(loginState,width,height);
    }
  }

  @override
  Widget build(BuildContext context) {
    //상태표지줄과 네비게이션 바와 겹치지 않는 안전한 영역을 반환
    return SafeArea(
        child: child,
    );
  }

  //위젯 Home
  Widget Home(bool loginState, double? width, double? height){
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){},
          )
      ),
    );
  }
}
