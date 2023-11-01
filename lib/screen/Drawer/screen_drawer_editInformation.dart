import 'package:flutter/material.dart';
import 'package:precycler/screen/screen_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:precycler/model/model_UserData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:precycler/widget/widget_custom.dart';

class EditInformationDrawer extends StatefulWidget {
  UserData? userData;

  EditInformationDrawer({super.key, this.userData});

  @override
  State<EditInformationDrawer> createState() => _EditInformationDrawerState();
}

class _EditInformationDrawerState extends State<EditInformationDrawer> {
  //변경할 이름
  String? name;

  //변경할 비번
  String? password;

  //변경할 비번 확인
  String? _password;

  //현재 비번으로 확인하여 변경이 가능한지를 확인하는 변수
  bool canChange = false;

  //비밀번호표시의 현재 아이콘
  IconData showPwdCurrenIcon = Icons.remove_red_eye;

  //비밀번호확인 표시의 현재 아이콘
  IconData _showPwdCurrenIcon = Icons.remove_red_eye;

  //기존 정보를 띄워놓기 위한 컨트롤러
  TextEditingController controller_n = TextEditingController();
  TextEditingController controller_p = TextEditingController();

  void initState(){
    //입력 박스의 text를 미리 지정
    controller_n.text = widget.userData!.name.toString();
    controller_p.text = widget.userData!.password.toString();

    //이름과 비번도 지정
    name = widget.userData!.name.toString();
    password = widget.userData!.password.toString();

  }

  Future<void> getchange() async {
    //포인트와 아이디 가져와서 저장
    String point = widget.userData!.point.toString();
    String id = widget.userData!.id.toString();

    //요청하면서 id, name, password, point 보냄
    final response = await http.put(
      Uri.parse('http://43.202.220.164:8000/change/'), // 실제 API 엔드포인트로 대체 하세요
      body: {
        'mid':id,
        'name':name,
        'password':password,
        'point':point,
      },
    );
    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      final responseData = json.decode(response.body);

      if(responseData=='ok'){
        widget.userData!.name = name;
        widget.userData!.password = password;
        flutter_show_toast("변경 성공");

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loginState', false);
        await prefs.setString('UserData_id','');
        await prefs.setString('UserData_password','');

        Navigator.pop(context);
        Navigator.pop(context);
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
      else if (responseData=="rpas"){
        Fluttertoast.showToast(
          msg: "비밀번호 양식 오류",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          fontSize: 15,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      else{
        flutter_show_toast("정보 변경 실패 2");
      }

    }else{
      flutter_show_toast("정보 변경 실패 1");
    }
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

          //제목 '개인 정보 변경'
          title: Text(
            '개인 정보 변경',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          //만약 현재 정보를 변경할 수 있는 상태라면
          child: (canChange)
              //변경 화면 표시
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Precycler
                    Padding(padding: EdgeInsets.only(top: height * 0.05),
                      child: Text('Precycler',
                        style: TextStyle(
                          fontSize: width * 0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),

                    //간격
                    SizedBox(
                      height: height * 0.05,
                    ),

                    // 이름 입력 필드
                    Container(
                      width: width * 0.8,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          border: Border.all(width: 2,color: Colors.white)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.short_text_outlined,color: Colors.white,),
                          SizedBox(
                            width: width * 0.6,
                            height: height * 0.068,
                            child: TextField(
                              controller: controller_n,
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              style: TextStyle(color:Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  hintText: '이름을 입력해주세요',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  filled: false,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.0583,
                          ),
                        ],
                      ),
                    ),

                    //간격
                    SizedBox(
                      height: height * 0.02,
                    ),

                    //비밀번호 입력 필드
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        width: width * 0.8,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                width * 0.03),
                            border: Border.all(width: 2,color: Colors.white)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.key,color: Colors.white,),
                            SizedBox(
                              width: width * 0.6,
                              height: height * 0.068,
                              child: TextField(
                                controller: controller_p,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },style: TextStyle(color:Colors.white),
                                cursorColor: Colors.white,
                                obscureText: (showPwdCurrenIcon == Icons.remove_red_eye)?true:false,
                                decoration: InputDecoration(
                                    hintText: '비밀번호를 입력해주세요',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    filled: false,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    )
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(maxWidth: 48),
                              splashRadius: 20,
                              iconSize: 25,
                              onPressed: () {
                                setState(() {
                                  if (showPwdCurrenIcon == Icons.remove_red_eye_outlined) {
                                    showPwdCurrenIcon = Icons.remove_red_eye;
                                  } else {
                                    showPwdCurrenIcon = Icons.remove_red_eye_outlined;
                                  }
                                });
                              },
                              icon: Icon(showPwdCurrenIcon,color: Colors.white,),
                            ),

                          ],
                        ),
                      ),
                    ),

                    //간격
                    SizedBox(
                      height: height * 0.02,
                    ),

                    //비밀번호 확인 입력 필드
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.05),
                      child: Container(
                        width: width * 0.8,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                width * 0.03),
                            border: Border.all(width: 2,color: Colors.white)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.key,color: Colors.white,),
                            SizedBox(
                              width: width * 0.6,
                              height: height * 0.068,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                style: TextStyle(color:Colors.white),
                                cursorColor: Colors.white,
                                obscureText: (_showPwdCurrenIcon == Icons.remove_red_eye)?true:false,
                                decoration: InputDecoration(
                                    hintText: '비밀번호를 다시 입력해주세요',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    filled: false,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    )
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(maxWidth: 48),
                              splashRadius: 20,
                              iconSize: 25,
                              onPressed: () {
                                setState(() {
                                  if (_showPwdCurrenIcon == Icons.remove_red_eye_outlined) {
                                    _showPwdCurrenIcon = Icons.remove_red_eye;
                                  } else {
                                    _showPwdCurrenIcon = Icons.remove_red_eye_outlined;
                                  }
                                });
                              },
                              icon: Icon(_showPwdCurrenIcon,color: Colors.white,),
                            ),

                          ],
                        ),
                      ),
                    ),

                    //회원가입 버튼
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
                          onPressed: () async {
                            if(password != _password){
                              flutter_show_toast("비밀번호 확인이 일치하지 않습니다");
                            }
                            else{
                              //회원가입 로직 동작
                              await getchange();
                            }
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
                          child: Text('정보 변경하기',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              //만약 변경할 수 없는 상태라면
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //현재 비밀번호 입력 창
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.03),
                      child: Container(
                        width: width * 0.8,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                width * 0.03),
                            border: Border.all(width: 2,color: Colors.white)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.key,color: Colors.white,),
                            SizedBox(
                              width: width * 0.6,
                              height: height * 0.068,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },style: TextStyle(color:Colors.white),
                                cursorColor: Colors.white,
                                obscureText: (_showPwdCurrenIcon == Icons.remove_red_eye)?true:false,
                                decoration: InputDecoration(
                                    hintText: '현재 비밀번호를 입력해주세요',
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    filled: false,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                    )
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(maxWidth: 48),
                              splashRadius: 20,
                              iconSize: 25,
                              onPressed: () {
                                setState(() {
                                  if (_showPwdCurrenIcon == Icons.remove_red_eye_outlined) {
                                    _showPwdCurrenIcon = Icons.remove_red_eye;
                                  } else {
                                    _showPwdCurrenIcon = Icons.remove_red_eye_outlined;
                                  }
                                });
                              },
                              icon: Icon(_showPwdCurrenIcon,color: Colors.white,),
                            ),

                          ],
                        ),
                      ),
                    ),

                    //변경 버튼
                    Padding(
                      //변경 버튼 아래쪽 패딩값을 화면 가로길이의 0.5배로
                      padding: EdgeInsets.fromLTRB(0, 0, 0, width * 0.3),

                      //버튼의 크기를 정하는 박스
                      child: SizedBox(
                        width: width * 0.5,
                        height: height * 0.06,
                        //버튼
                        child: ElevatedButton(
                          //버튼 입력시 실행 정보
                          onPressed: () {
                            showPwdCurrenIcon = Icons.remove_red_eye;
                            if(_password == widget.userData!.password){
                              setState(() {
                                canChange = true;
                              });
                            }
                            else{
                              flutter_show_toast("비밀번호가 일치하지 않습니다");
                            }
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
                          child: Text('변경하기',
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
