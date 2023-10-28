import 'package:flutter/material.dart';

class HelpDrawer extends StatefulWidget {
  const HelpDrawer({super.key});

  @override
  State<HelpDrawer> createState() => _HelpDrawerState();
}

class _HelpDrawerState extends State<HelpDrawer> {
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
            '도움말',
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
