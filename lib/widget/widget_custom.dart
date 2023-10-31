import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final double width;
  final double height;
  final String hint;
  final Function(String) onChanged;

  TextInput({
    required this.width,
    required this.height,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.8,
      height: height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(width: 1, color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, color: Colors.white),
          SizedBox(
            width: width * 0.6,
            height: height * 0.068,
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                filled: false,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.0583,
          ),
        ],
      ),
    );
  }
}