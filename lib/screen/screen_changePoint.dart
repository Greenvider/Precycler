import 'package:flutter/material.dart';

class ChangePointScreen extends StatefulWidget {
  final String IncDec;

  const ChangePointScreen({super.key, required String this.IncDec});

  @override
  State<ChangePointScreen> createState() => _ChangePointScreenState();
}

class _ChangePointScreenState extends State<ChangePointScreen> {

  void initState() {
    super.initState();
    // 3초 후에 페이지를 pop합니다.
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
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
              (widget.IncDec == "Dec")? "00포인트를 00에 사용했습니다":"00포인트를 획득하였습니다",
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
