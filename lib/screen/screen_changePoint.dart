import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePointScreen extends StatefulWidget {

  const ChangePointScreen({super.key});

  @override
  State<ChangePointScreen> createState() => _ChangePointScreenState();
}

class _ChangePointScreenState extends State<ChangePointScreen> {
  String IncDec = "Inc";

  void initState() {
    super.initState();
    if(IncDec!=""){
      // 3초 후에 페이지를 pop합니다.
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
      });
    }
    else{
      _showToast();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Precycler2.png',width: 200,),
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
  void _showToast(){
    Fluttertoast.showToast(
      msg: "failed to scan QR code",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey,
      fontSize: 15,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
