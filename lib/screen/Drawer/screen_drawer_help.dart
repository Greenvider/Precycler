import 'package:flutter/material.dart';

class HelpDrawer extends StatefulWidget {
  const HelpDrawer({super.key});

  @override
  State<HelpDrawer> createState() => _HelpDrawerState();
}

class _HelpDrawerState extends State<HelpDrawer> {
  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          //appBar 배경화면 한얀색
          backgroundColor: Colors.black,

          //appBar 그림자 없애기
          elevation: 0,

          title: Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          //
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
            child: Container(
              width: width*0.9,
              child: SingleChildScrollView(
                child: Text(
                      "Q1. 카메라가 동작하지 않아요\n"
                      "A. 앱을 재실행 하시면 다시 촬영하실 수 있습니다.\n\n"
                      "Q2. QR 인식이 어려워요\n"
                      "A. 빛반사를 줄이고 밝은 곳에서 다시 시도해보세요\n"
                      "그리고 QR 코드가 격자보다 살짝 작게 하면 인식이 더 잘됩니다.\n\n"
                      "Q3. 정보 변경을 어떻게 하나요?\n"
                      "A. 이름과 비밀번호는 기존 정보로 채워져 있고 바꾸고 싶은 정보만 바꾸고 완료하시면 됩니다\n\n\n\n\n\n\n\n\n"
                  ,style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}
