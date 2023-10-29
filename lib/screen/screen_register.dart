import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'screen_login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String name;

  //회원가입 창에서 입력받을 아이디
  late String id;

  //회원가입 창에서 입력받을 비밀번호
  late String password;

  //회원가입 창에서 입력받을 재입력 비밀번호
  late String _password;

  //비밀번호표시의 현재 아이콘
  IconData showPwdCurrenIcon = Icons.remove_red_eye_outlined;

  //재입력 비밀번호표시의 현재 아이콘
  IconData _showPwdCurrenIcon = Icons.remove_red_eye_outlined;

  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    //상태표지줄과 네비게이션 바와 겹치지 않는 안전한 영역을 반환
    return SafeArea(
        child: Scaffold(
          //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
          resizeToAvoidBottomInset: false,

          //body는 Center
          body: Center(
            //세로 정렬
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Precycler
                Text('Precycler',
                  style: TextStyle(
                    fontSize: width * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //간격
                SizedBox(
                  height: height * 0.1,
                ),

                //이름 입력 필드
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      border: Border.all(width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.short_text_outlined),
                      SizedBox(
                        width: width * 0.6,
                        height: height * 0.068,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: '이름을 입력해주세요',
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
                        width: width * 0.0583,
                      ),
                    ],
                  ),
                ),

                //간격
                SizedBox(
                  height: height * 0.02,
                ),

                //아이디 입력 필드
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      border: Border.all(width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(
                        width: width * 0.6,
                        height: height * 0.068,
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
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          width * 0.03),
                      border: Border.all(width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.key),
                      SizedBox(
                        width: width * 0.6,
                        height: height * 0.068,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: (showPwdCurrenIcon == Icons.remove_red_eye)?true:false,
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
                        border: Border.all(width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.key),
                        SizedBox(
                          width: width * 0.6,
                          height: height * 0.068,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            obscureText: (_showPwdCurrenIcon == Icons.remove_red_eye)?true:false,
                            decoration: InputDecoration(
                                hintText: '비밀번호를 다시 입력해주세요',
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
                              if (_showPwdCurrenIcon == Icons.remove_red_eye_outlined) {
                                _showPwdCurrenIcon = Icons.remove_red_eye;
                              } else {
                                _showPwdCurrenIcon = Icons.remove_red_eye_outlined;
                              }
                            });
                          },
                          icon: Icon(_showPwdCurrenIcon),
                        ),

                      ],
                    ),
                  ),
                ),

                //회원가입 버튼
                Padding(
                  //회원가입 버튼 아래쪽 패딩값을 화면 가로길이의 0.5배로
                  padding: EdgeInsets.fromLTRB(0, 0, 0, width * 0.3),

                  //버튼의 크기를 정하는 박스
                  child: SizedBox(
                    width: width * 0.5,
                    height: height * 0.06,
                    //버튼
                    child: ElevatedButton(
                      //버튼 입력시 실행 정보
                        onPressed: () {
                          //회원가입 로직 동작

                          //현재 페이지 종료
                          Navigator.pop(context);

                          //홈 페이지로 전환
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
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
                        child: Text('회원가입',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
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