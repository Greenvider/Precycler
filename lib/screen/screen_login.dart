import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'screen_register.dart';

class LoginScreen extends StatefulWidget {
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
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
        child: Scaffold(
          //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,

          //body는 Center
          body: Center(
            //세로 정렬
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Precycler
                Text('Precycler',
                  style: TextStyle(
                    fontSize: width * 0.15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),

                //간격
                SizedBox(
                  height: height * 0.1,
                ),

                // 아이디 입력 필드
                Container(
                  width: width * 0.8,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.03),
                      border: Border.all(width: 1,color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle,color: Colors.white,),
                      SizedBox(
                        width: width * 0.6,
                        height: height * 0.068,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              id = value;
                            });
                          },
                          style: TextStyle(color:Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              hintText: '아이디를 입력해주세요',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
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
                  padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.05),
                  child: Container(
                    width: width * 0.8,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            width * 0.03),
                        border: Border.all(width: 1,color: Colors.white)
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
                                password = value;
                              });
                            },
                            style: TextStyle(color:Colors.white),
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

                //로그인 버튼
                Padding(
                  //로그인 버튼 아래쪽 패딩값을 화면 가로길이의 0.5배로
                  padding: EdgeInsets.fromLTRB(0, 0, 0, width * 0.01),

                  //버튼의 크기를 정하는 박스
                  child: SizedBox(
                    width: width * 0.5,
                    height: height * 0.06,
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
                            backgroundColor: Colors.black,
                            side: BorderSide(
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(height * 0.02),
                            )
                        ),

                        //버튼 내용
                        child: Text('로그인',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                    ),
                  ),
                ),

                //회원가입 버튼
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, height*0.27),
                  child: TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterScreen())
                      );
                    },
                    child: Text('회원가입',style: TextStyle(color: Colors.white),),

                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}