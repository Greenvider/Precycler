import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'widget/widget_loginOrHome.dart';
import 'package:flutter/services.dart';

void main()async{
  //앱이 시작하는 동시에 스플래쉬 화면을 나타나게 하여 HomeScreen이 로드될때까지 표시한다.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //전체화면
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.bottom]);

  //화면 세로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //MyApp 위젯을 실행
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return MaterialApp(
      //디버깅 모드에서 표시되는 배너를 가리기
      debugShowCheckedModeBanner: false,

      //제목을 Precycler로
      title: 'Precycler',

      //home은 로그인 여부에 따른 위젯표시를 해줄 위젯호출
      home: LoginOrHome(width:width,height:height)
    );
  }
}
