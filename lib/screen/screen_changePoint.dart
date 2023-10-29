import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePointScreen extends StatefulWidget {
  @override
  State<ChangePointScreen> createState() => _ChangePointScreenState();
}

class _ChangePointScreenState extends State<ChangePointScreen> {
  //변경할 포인트가 증가인지 감소인지 판별할 변수
  String IncDec = "Inc";

  //위젯 초기화 함수
  void initState() {
    super.initState();
    //qr 분석 후 IncDec 변수 변경


    //만약 qr분석에 실패하지 않았다면
    if(IncDec!=""){
      // 3초 후에 페이지를 pop합니다.
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
    //qr 분석에 실패했다면
    else{
      //실패문구 띄우기
      Fluttertoast.showToast(
        msg: "failed to scan QR code",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.grey,
        fontSize: 15,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );

      //창 종료
      Navigator.pop(context);
    }
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
              (IncDec == "Dec")? "00포인트를 00에 사용했습니다":"00포인트를 획득하였습니다",
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
