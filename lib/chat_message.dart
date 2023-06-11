import 'package:flutter/material.dart';
import 'chat_screen_layout.dart';
class chat_message extends StatelessWidget {
  const chat_message({super.key, required this.text, required this.sender});
  final String text;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 16,bottom: 5),
          child: CircleAvatar(
            radius: 30,
            backgroundImage: sender=='Batman'? AssetImage(
              'images/batman.jpg',
            ):AssetImage(
              'images/alfred1.jpg',
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5,bottom: 5,right: 10,top: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
