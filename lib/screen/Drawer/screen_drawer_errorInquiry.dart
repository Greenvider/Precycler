import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:precycler/model/model_UserData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ErrorInquiryDrawer extends StatefulWidget {
  UserData? userData;

  ErrorInquiryDrawer({super.key, this.userData});

  @override
  State<ErrorInquiryDrawer> createState() => _ErrorInquiryDrawerState();
}

class _ErrorInquiryDrawerState extends State<ErrorInquiryDrawer> {
  //문의 내용
  String inquiry = "";

  Future<UserData?> putInquiry(UserData userData) async {
    final response = await http.post(
      Uri.parse('http://43.202.220.164:8000/inquiry/'), // 실제 API 엔드포인트로 대체하세요
      body: {
        'mid': userData.id,
        'content':inquiry,
      },
    );
    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      final responseData = json.decode(response.body);
      if(responseData == 'ok'){
        Fluttertoast.showToast(
          msg: "문의가 정상적으로 진행되었습니다",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          fontSize: 15,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      else{
        Fluttertoast.showToast(
          msg: "문의를 보내는 중 에러가 발생하였습니다",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          fontSize: 15,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "문의 양식이 올바르지 않습니다",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        fontSize: 15,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return userData;
  }

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
        backgroundColor: Colors.black,
        appBar: AppBar(
          //appBar 배경화면 한얀색
          backgroundColor: Colors.black,

          //appBar 그림자 없애기
          elevation: 0,

          title: Text(
            '버그 문의',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //간격
              SizedBox(
                height: height*0.1,
              ),

              //입력 필드
              SizedBox(
                width: width * 0.8,
                child: TextField(
                  //값이 변하면
                  onChanged: (value) {
                    setState(() {
                      //변수에 저장
                      inquiry = value;
                    });
                  },
                  maxLength: 500,
                  style: TextStyle(color:Colors.white),
                  cursorColor: Colors.white,
                  //꾸미기
                  decoration: InputDecoration(
                      hintText: '문의 내용을 설명해주세요',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      filled: false,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2,color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                  ),

                  //최대 최소 길이
                  minLines: 13,
                  maxLines: 13,
                ),
              ),

              //간격
              SizedBox(
                height: height*0.03,
              ),

              //문의하기 버튼
              Padding(
                //문의하기 버튼 아래쪽 패딩값을 화면 가로길이의 0.5배로
                padding: EdgeInsets.fromLTRB(0, 0, 0, width * 0.3),

                //버튼의 크기를 정하는 박스
                child: SizedBox(
                  width: width * 0.5,
                  height: height * 0.06,
                  //버튼
                  child: ElevatedButton(
                    //버튼 입력시 실행 정보
                    onPressed: () {
                      //문의하기 로직 동작
                      putInquiry(widget.userData!);

                      Navigator.pop(context);
                    },

                    //버튼 스타일
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: BorderSide(
                          color: Colors.white,
                          width: 2
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(height * 0.02)
                        )
                    ),

                    //버튼 내용
                    child: Text('문의하기',
                      style: TextStyle(
                          color: Colors.white,
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
