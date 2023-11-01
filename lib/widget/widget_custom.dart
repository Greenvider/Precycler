import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void flutter_show_toast(String text){
  Fluttertoast.showToast(
    msg: text,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.grey,
    fontSize: 15,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG,
  );
}