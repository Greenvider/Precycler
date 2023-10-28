import 'package:flutter/material.dart';

class PolicyDrawer extends StatefulWidget {
  const PolicyDrawer({super.key});

  @override
  State<PolicyDrawer> createState() => _PolicyDrawerState();
}

class _PolicyDrawerState extends State<PolicyDrawer> {
  @override
  Widget build(BuildContext context) {
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
          //
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(

        ),
      ),
    );
  }
}
