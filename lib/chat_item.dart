import 'package:flutter/material.dart';
import 'dart:math';

class ChatItem extends StatelessWidget {
  final String userName;
  final List<Color> _colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  Color getRandomColor() {
    Random random = Random();
    return _colorList[random.nextInt(_colorList.length)];
  }

  ChatItem({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFF5E7A90), width: 1),
          bottom: BorderSide(color: Color(0xFF5E7A90), width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getRandomColor(),
              ),
              child: Center(
                child: Text(
                  userName.isNotEmpty ? userName.substring(0, 1) : '',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Последнее сообщение',
                  style: TextStyle(color: Color(0xFF5E7A90)),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Дата',
                  style: TextStyle(color: Color(0xFF5E7A90)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
