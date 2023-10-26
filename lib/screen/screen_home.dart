import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'screen_login.dart';

class HomeScreen extends StatefulWidget {
  double? width;
  double? height;

  HomeScreen({super.key,this.width,this.height});
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    //상태표지줄과 네비게이션 바와 겹치지 않는 안전한 영역을 반환
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          drawer: Drawer(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(0, width!*0.1, 0, 0),
                      children: [
                        //포인트 이용 내역
                        ListTile(
                          title: Text('포인트 이용 내역',textAlign: TextAlign.center,),
                          onTap: (){
                            // 네이게이터 팝을 통해 드로워를 닫는다.
                            Navigator.pop(context);
                          },
                        ),
                        //버그 문의
                        ListTile(
                          title: Text('버그 문의',textAlign: TextAlign.center),
                          onTap: (){
                            // 드로워를 닫음
                            Navigator.pop(context);
                          },
                        ),
                        //도움말
                        ListTile(
                          title: Text('도움말',textAlign: TextAlign.center,),
                          onTap: (){
                            // 네이게이터 팝을 통해 드로워를 닫는다.
                            Navigator.pop(context);
                          },
                        ),
                        //정책
                        ListTile(
                          title: Text('정책',textAlign: TextAlign.center),
                          onTap: (){
                            // 드로워를 닫음
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: width*0.04),
                    child: ListTile(
                      title: Text('로그아웃',textAlign: TextAlign.center,),
                      onTap: (){

                      },
                    ),
                )
              ],
            )
          ),
          body: Stack(
            children: [
              DraggableScrollableSheet(
                initialChildSize: 0.15, // 시작할 때 하단에서 보일 높이 (0.0에서 1.0 사이)
                minChildSize: 0.15, // 최소 높이 (0.0에서 1.0 사이)
                maxChildSize: 0.95, // 최대 높이 (0.0에서 1.0 사이)
                expand: true, // 위로 슬라이드하여 확장할 수 있는지 여부
                builder: (context, scrollController) {
                  return Container(
                    color: Colors.transparent,
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Container(
                          height: height*0.843,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: Colors.transparent
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, width*0.05, 0, width*0.06),
                                child: Icon(Icons.keyboard_arrow_up_rounded,size: 70,),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, width*0.06),
                                child: Text(
                                  '현재 위치 : 00시 00구 00동 ~로',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: 50,
                                  itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets. symmetric (vertical: 10, horizontal: 40),
                                        child: ListTile(
                                          minVerticalPadding: 40,
                                          title: Text('Item $index',textAlign: TextAlign.center,),
                                        ),
                                      );
                                    },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
    );
  }

  //위젯 Home
  Widget Home(double? width, double? height){
    return Scaffold(
      //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
      resizeToAvoidBottomInset: false,
      appBar: AppBar(

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, width!*0.5, 0, 10),
          children: [
            ListTile(
              title: Text('Item 1',textAlign: TextAlign.center,),
              onTap: (){
                // 네이게이터 팝을 통해 드로워를 닫는다.
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2',textAlign: TextAlign.center),
              onTap: (){
                // 드로워를 닫음
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
