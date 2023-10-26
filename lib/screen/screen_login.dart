import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'screen_home.dart';

class LoginScreen extends StatefulWidget {
  double? width;
  double? height;

  LoginScreen({super.key,this.width,this.height});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //로그인 창에서 입력받을 아이디
  late String id;

  //로그인 창에서 입력받을 비밀번호
  late String password;

  //비밀번호표시의 현재 아이콘
  IconData showPwdCurrenIcon = Icons.remove_red_eye_outlined;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Precycler
                Text('Precycler',
                  style: TextStyle(
                    fontSize: widget.width! * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //간격
                SizedBox(
                  height: widget.height! * 0.1,
                ),

                // 아이디 입력 필드
                Container(
                  width: widget.width! * 0.8,
                  height: widget.height! * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.width! * 0.03),
                      border: Border.all(width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(
                        width: widget.width! * 0.6,
                        height: widget.height! * 0.068,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              id = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: '아이디를 입력해주세요',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              filled: false,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widget.width! * 0.0583,
                      ),
                    ],
                  ),
                ),

                //간격
                SizedBox(
                  height: widget.height! * 0.02,
                ),

                //비밀번호 입력 필드
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, widget.height! * 0.05),
                  child: Container(
                    width: widget.width! * 0.8,
                    height: widget.height! * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            widget.width! * 0.03),
                        border: Border.all(width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.key),
                        SizedBox(
                          width: widget.width! * 0.6,
                          height: widget.height! * 0.068,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: '비밀번호를 입력해주세요',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: false,
                                enabledBorder: OutlineInputBorder(
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
                          icon: Icon(showPwdCurrenIcon),
                        ),

                      ],
                    ),
                  ),
                ),

                //로그인 버튼
                Padding(
                  //로그인 버튼 아래쪽 패딩값을 화면 가로길이의 0.5배로
                  padding: EdgeInsets.fromLTRB(0, 0, 0, widget.width! * 0.5),

                  //버튼의 크기를 정하는 박스
                  child: SizedBox(
                    width: widget.width! * 0.5,
                    height: widget.height! * 0.06,
                    //버튼
                    child: ElevatedButton(
                      //버튼 입력시 실행 정보
                        onPressed: () {
                          //로그인 로직 동작

                          //현재 페이지 종료
                          Navigator.pop(context);

                          //홈 페이지로 전환
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },

                        //버튼 스타일
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: Color(0xFF595959),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget
                                    .height! * 0.02)
                            )
                        ),

                        //버튼 내용
                        child: Text('로그인',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}