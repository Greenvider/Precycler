import 'package:flutter/material.dart';

class ErrorInquiryDrawer extends StatefulWidget {
  const ErrorInquiryDrawer({super.key});

  @override
  State<ErrorInquiryDrawer> createState() => _ErrorInquiryDrawerState();
}

class _ErrorInquiryDrawerState extends State<ErrorInquiryDrawer> {
  String inquiry = "";

  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          //appBar 배경화면 한얀색
          backgroundColor: Colors.white,

          //appBar 그림자 없애기
          elevation: 0,

          title: Text(
            '버그 문의',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          //
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height*0.1,
              ),
              SizedBox(
                width: width * 0.8,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inquiry = value;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: '문의 내용을 설명해주세요',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1)
                      )
                  ),
                  minLines: 13,
                  maxLines: 13,
                ),
              ),
              SizedBox(
                height: height*0.03,
              ),
              Padding(
                //로그인 버튼 아래쪽 패딩값을 화면 가로길이의 0.5배로
                padding: EdgeInsets.fromLTRB(0, 0, 0, width * 0.3),

                //버튼의 크기를 정하는 박스
                child: SizedBox(
                  width: width * 0.5,
                  height: height * 0.06,
                  //버튼
                  child: ElevatedButton(
                    //버튼 입력시 실행 정보
                    onPressed: () {
                      //로그인 로직 동작

                      Navigator.pop(context);
                    },

                    //버튼 스타일
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: Color(0xFF595959),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height * 0.02)
                        )
                    ),

                    //버튼 내용
                    child: Text('문의하기',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
