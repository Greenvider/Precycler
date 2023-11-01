import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'screen_ad.dart';
import 'package:precycler/model/model_UserData.dart';

class ChangePointScreen extends StatefulWidget {
  //변경할 포인트가 증가인지 감소인지 판별할 변수
  String IncDec = "";

  //변경한 포인트
  int ChangePoint = 0;

  //사용자 데이터
  UserData? userData;

  ChangePointScreen({required this.IncDec,required this.ChangePoint, this.userData});

  @override
  State<ChangePointScreen> createState() => _ChangePointScreenState();
}

class _ChangePointScreenState extends State<ChangePointScreen> {


  //위젯 초기화 함수
  void initState() {
    super.initState();

    // 3초 후에 광고페이지로 전환
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
      Navigator.push(context,MaterialPageRoute(builder: (context)=>AdScreen(userData: widget.userData,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //중앙 정렬
      body: Center(
        //세로 정렬
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //로고 가져오기
            Image.asset('assets/Precycler2.png',width: 200,),

            //포인트 사용 문구 출력
            Text(
              (widget.IncDec == "Dec")? "${widget.ChangePoint}포인트를 00에 사용했습니다":"${widget.ChangePoint}포인트를 획득하였습니다",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
