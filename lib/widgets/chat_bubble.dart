import 'package:flutter/material.dart';
import 'package:frist_project/constant.dart';
import 'package:frist_project/model/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,required this.message
  });
 final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 18, bottom: 32, top: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
         message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    super.key,required this.message
  });
 final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 18, bottom: 32, top: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
         message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

