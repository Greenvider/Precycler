import 'package:flutter/material.dart';

class PointHistoryDrawer extends StatefulWidget {
  const PointHistoryDrawer({super.key});

  @override
  State<PointHistoryDrawer> createState() => _PointHistoryDrawerState();
}

class _PointHistoryDrawerState extends State<PointHistoryDrawer> {
  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          //appBar 배경화면 한얀색의
          backgroundColor: Colors.black,

          //appBar 그림자 없애기
          elevation: 0,

          //제목
          title: Text(
            '포인트 이용 내역',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          //이용 내역 builder
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              //카드형식 반환
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(width: 2,color: Colors.white)
                ),
                margin: EdgeInsets. symmetric (vertical: 10, horizontal: 40),
                color: Colors.black,
                //컨테이너
                child: Container(
                    width: width*0.8,
                    height: height*0.12,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text((index%2==0)?'$index 버스':'$index 가게',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                color: Colors.white
                              ),
                            ),
                            Text('yyyy/mm/dd hh:mm:ss',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),
                            Text('0000시 성북구 화랑도 11길 26',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),

                          ],
                        ),
                        Text((index%2==0)?'+ '+'$index'+'P':'- '+'$index'+'P',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                        ),
                      ],
                    )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
