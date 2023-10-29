import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';


class PolicyDrawer extends StatefulWidget {
  const PolicyDrawer({super.key});

  @override
  State<PolicyDrawer> createState() => _PolicyDrawerState();
}

class _PolicyDrawerState extends State<PolicyDrawer> {
  //정책 문구
  String fileContent = "";

  Future<String> readTextFile() async {
    try {
      final String path = await rootBundle.loadString('assets/policy_.txt');
      return path;
    } catch (e) {
      return '파일을 불러올 수 없습니다: $e';
    }
  }

  @override
  void initState() {
    super.initState();
    readTextFile().then((content) {
      setState(() {
        fileContent = content;
      });
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          //appBar 배경화면 한얀색
          backgroundColor: Colors.white,

          //appBar 그림자 없애기
          elevation: 0,

          title: Text(
            '정책',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Container(
            width: width*0.9,
            child: SingleChildScrollView(
              child: Text(
                  fileContent
              ),
            ),
          )
        ),
      ),
    );
  }
}
