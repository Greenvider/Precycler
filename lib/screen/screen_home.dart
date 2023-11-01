import 'package:flutter/material.dart';
import 'package:precycler/widget/widget_camera.dart';
import 'package:precycler/screen/Drawer/screen_drawer_pointHistory.dart';
import 'package:precycler/screen/Drawer/screen_drawer_editInformation.dart';
import 'package:precycler/screen/Drawer/screen_drawer_errorInquiry.dart';
import 'package:precycler/screen/Drawer/screen_drawer_help.dart';
import 'package:precycler/screen/Drawer/screen_drawer_policy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:precycler/model/model_UserData.dart';
import 'package:precycler/model/model_StoreData.dart';
import "package:flutter/foundation.dart";
import 'screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:precycler/widget/widget_custom.dart';

//이름, 포인트 불러오기
Future<UserData?> getPoint(UserData userData) async {
  final response = await http.post(
    Uri.parse('http://43.202.220.164:8000/point/'), // 실제 API 엔드포인트로 대체하세요
    body: {
      'mid': userData.id,
    },
  );
  //정상 응답일때
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    List<String> r = responseData.toString().split('|');
    userData.point = int.parse(r[1]);
    userData.name = r[0];
  }

  //정상 응답이 아닐때
  else {
    flutter_show_toast("포인트 불러오기 실패");
  }
  return userData;
}

class HomeScreen extends StatefulWidget {
  UserData? userData;
  HomeScreen({super.key,this.userData});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //위도
  double latitude = 0;
  //경도
  double longitude = 0;
  //주소
  String myLocation = '';

  //가져온 가게 데이터들 리스트
  List<StoreData> mapdata = [];

  @override
  void initState() {
    //포인트와 이름 가져오기
    get();

    //가게 정보와 현재 자신의 위치 가져오기
    getLocationData();
  }

  //포인트, 이름 가져오기 함수
  void get() async {
    widget.userData = await getPoint(widget.userData!);
  }

  //가게 정보 가져오기
  Future<void> getMap(String lat, String log) async {
    final response = await http.post(
      Uri.parse('http://43.202.220.164:8000/map/'), // 실제 API 엔드포인트로 대체하세요
      body: {
        //위도, 경도와 함께 요청 보내기
        'lat':lat,
        'log':log,
      },
    );
    //정상적인 응답을 받았을 때
    if (response.statusCode == 200) {
      //응답 저장
      final responseData = json.decode(response.body);

      //응답을 그 개수만큼 반복
      for(var a in responseData){
        //이름과 주소가 뭉쳐있는 형태 저장
        var b = a['nl'];

        //거리 int로 전환
        int c = a['dis'].toInt();

        // '|'를 기준으로 앞쪽이 가게 이름, 뒤쪽이 가게 주소
        var e = (b.toString()).split('|');

        //만약 거리가 1000m 이상이면 단위를 km로 전환, 아니면 그대로 m 단위로 표시
        var t = (c >= 1000)?((double.parse(((c/1000).toString())+((c%1000).toString())).toStringAsFixed(2)).toString())+" km":c.toString()+" m";

        //이름, 주소, 거리를 가게 정보를 저장하는 리스트에 추가
        StoreData s = StoreData(name: e[0], address: e[1], distance: t);
        mapdata.add(s);
      }
    }

    //정상적인 응답을 받지 못했을 때
    else {
      //가게 정보 불러오기 실패 표시
      flutter_show_toast("가게 정보 불러오기 실패");
    }
  }

  //현재 주소 가져오기
  Future<void> getPos(String lat, String log) async {
    print(lat.toString() +" 1 "+log.toString());
    final response = await http.post(
      Uri.parse('http://43.202.220.164:8000/addr/'), // 실제 API 엔드포인트로 대체하세요
      body: {
        'lat':lat,
        'log':log,
      },
    );
    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      final responseData = json.decode(response.body);
      myLocation = responseData.toString();
    }
  }

  //위도 경도 가져오면서 주소와 가게 정보 가져오기
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;

    getMap(latitude.toString(),longitude.toString());

    getPos(latitude.toString(),longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    //미디어 쿼리로 width와 height을 지정하여 상대적인 수치 사용
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    //DraggableScrollableSheet의 최대, 최소 크기
    double maxheight = height*0.3;
    double minheight = height;

    //상태표지줄과 네비게이션 바와 겹치지 않는 안전한 영역을 반환
    return SafeArea(
        child: Scaffold(
          //배경 색은 하얀색으로
          backgroundColor: Colors.black,

          //키보드를 활성화해도 위젯이 위로 올라가지 않도록 설정
          resizeToAvoidBottomInset: false,

          //appBar
          appBar: AppBar(
            //appBar 배경화면 한얀색
            backgroundColor: Colors.black,

            //appBar 그림자 없애기
            elevation: 0,

            //appbar의 아이콘 색은 black으로
            iconTheme: IconThemeData(color: Colors.white),
          ),

          //drawer
          drawer: Drawer(
            backgroundColor: Colors.black,
            //column, 세로 정렬
            child: Column(
              children: [
                //drawer 메뉴의 항목들을 넣을 공간을 최대한 채우기
                Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(0, width*0.1, 0, 0),
                      children: [
                        //개인정보 변경
                        ListTile(
                          title: Text(
                            '개인정보 변경',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width*0.05,
                              color: Colors.white,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditInformationDrawer(userData: widget.userData,),
                              ),
                            );
                          },
                        ),

                        //버그 문의
                        ListTile(
                          title: Text(
                            '버그 문의',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width*0.05,
                              color: Colors.white,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ErrorInquiryDrawer(userData: widget.userData,),
                              ),
                            );
                          },
                        ),

                        //도움말
                        ListTile(
                          title: Text(
                            '도움말',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width*0.05,
                              color: Colors.white,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HelpDrawer(),
                              ),
                            );
                          },
                        ),

                        //정책
                        ListTile(
                          title: Text(
                            '정책',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width*0.05,
                              color: Colors.white,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PolicyDrawer(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ),

                //로그아웃 부분
                Padding(
                    padding: EdgeInsets.only(bottom: width*0.04),
                    child:Row(
                      children: [
                        Flexible(
                            child: ListTile(
                              title: Text('로그아웃',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),

                              //로그아웃을 누르면
                              onTap: () async {
                                //로그인 상태를 false로 나머지 사용자 정보를 다 초기화 시키기
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setBool('loginState', false);
                                await prefs.setString('UserData_id','');
                                await prefs.setString('UserData_password','');

                                Navigator.pop(context);
                                Navigator.pop(context);
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                            ),
                        ),
                      ],
                    )
                )
              ],
            )
          ),

          //body 부분, scrollableSheet와 겹쳐야 하므로 Stack 사용
          body: Stack(
            children: [
              //가운데 부분에는 카메라 뷰어와 셔터버튼이 들어가야하므로 커스텀 위젯인 CameraWidget 호출
              Center(
                child: CameraWidget(userData:widget!.userData),
              ),
              //말그대로 드래그가 가능하고 스크롤도 가능한 시트이다
              DraggableScrollableSheet(
                initialChildSize: 0.15,
                minChildSize: 0.15,
                maxChildSize: 1,
                expand: true,
                snap: false,
                builder: (context, scrollController) {
                  //LayoutBuilder로 ListView를 만들기
                  return LayoutBuilder(builder: (context,constraints) {
                    //DraggableScrollableSheet의 height크기를 가져와 sheetHeight에 저장
                    double sheetHeight = constraints.maxHeight;
                    //sheetHeight의 변화에 따라 최대, 최소크기 지정
                    maxheight = (maxheight < sheetHeight)? sheetHeight : maxheight;
                    minheight = (minheight > sheetHeight)? sheetHeight : minheight;
                    //리스트뷰 반환
                    return ListView(
                      controller: scrollController,
                      children: [
                        //리스트로 사용할 컨테이너를 호출
                        Container(
                          height: (maxheight<height*0.3)?height*0.3:maxheight,
                          decoration: BoxDecoration(
                              border: Border.all(width: 5,color: Colors.white),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              color: Colors.black
                          ),

                          //컨테이너 내부에 Column, 세로 정렬
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //드래그하여 올릴 부분이며 내부에 화살표가 있다
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, width*0.05, 0, width*0.06),
                                child: Icon(Icons.keyboard_arrow_up_rounded,size: 70,color: Colors.white,),
                              ),

                              //현재 위치 표시 위젯
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, width*0.06),
                                child: Text(
                                  '현재위치 : ${myLocation}',
                                  style: TextStyle(
                                    fontSize: width*0.05,
                                    color: Colors.white
                                  ),
                                ),
                              ),

                              //포인트 획득 가능 가게들과 주소, 나와 떨어진 거리 표시 위젯
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,

                                  //불러온 가게 개수만큰 리스트 뷰 생성
                                  itemCount: mapdata.length,
                                  itemBuilder: (context, index) {
                                    StoreData s = mapdata[index];
                                    return Card(
                                      elevation: 5,
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: Colors.white,width: 2)
                                      ),
                                      margin: EdgeInsets. symmetric (vertical: 10, horizontal: 40),
                                      child: Container(
                                          width: width*0.8,
                                          height: height*0.12,
                                          color: Colors.black,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: width*0.55,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: width*0.45,
                                                      child: Text('${s.name}',
                                                        style: TextStyle(
                                                            fontSize: width*0.045,
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width*0.45,
                                                      child: Text('${s.address}',
                                                        style: TextStyle(
                                                            fontSize: width*0.03,
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Text('${s.distance}',
                                                  style: TextStyle(
                                                      fontSize: width*0.05,
                                                      color: Colors.white
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
                },
              ),
            ],
          ),
        ),
    );
  }
}

//위도 경도 구할때 필요한 클래스
class Location {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
