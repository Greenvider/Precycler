import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  double? width;
  double? height;

  LoginScreen({super.key,this.width,this.height});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Precycler',
                  style: TextStyle(
                    fontSize: widget.width!*0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: widget.height!*0.1,
                ),
                // 이메일 입력 필드
                Padding(
                  padding: EdgeInsets.fromLTRB(widget.width!*0.1,0,widget.width!*0.1,widget.height!*0.025),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '이메일',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(widget.width!*0.1,0,widget.width!*0.1,widget.height!*0.025),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: '비밀번호',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){},
                    child: Text('로그인')
                )
              ],
            ),
          ),
        )
    );
  }
}
