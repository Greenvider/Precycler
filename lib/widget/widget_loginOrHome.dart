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

  //여기부터 시작해서 모든 페이지를 거치며 사용자의 정보를 저장할 변수 생성
  UserData userData = UserData(id: '',password: '',point: 0,name: '');

  //페이지 로딩 화면 보이기
  bool loding = true;

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
    //초기화
    init();

    //로딩중이 참이면 로딩화면
    if(loding){
      return SafeArea(child: Scaffold(backgroundColor: Colors.black,body: Center(child: CircularProgressIndicator(),),));
    }
    //아니면 Login 이나 Home screen 띄우기
    else{
      return SafeArea(child: child);
    }
  }

  //초기화 함수
  Future<void> init() async {
    //이전 로그인 기록 가져오기
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? login_state = prefs.getBool('loginState');

    //로그인 기록이 null 이 아니고 true 라면 로그인 상태를 true, 아니면 false
    setState(() {
      loginState = (login_state != null && login_state)?true:false;
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
      //마지막 로그인 되었던 id 와 password를 가져오기
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        final String? user_data_id = prefs.getString('UserData_id');
        final String? user_data_password = prefs.getString('UserData_password');

        //사용자 정보 저장 변수에 저장
        userData.id = user_data_id;
        userData.password = user_data_password;

        //사용자 정보와 함께 Home 화면으로 이동
        child = HomeScreen(userData: userData,);

        //로딩 종료
        loding = false;
      });
      //Home위젯 보이기
    }
  }

}
