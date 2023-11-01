import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'screen_home.dart';


class AdScreen extends StatefulWidget {
  const AdScreen({super.key});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {

  void initState() {
    super.initState();

    // 3초 후에 페이지를 pop합니다.
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            '광고 표시화면',
            style: TextStyle(
              fontSize: width*0.1,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
