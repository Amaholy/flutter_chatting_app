import 'package:flutter/material.dart';

enum MessageType { MyMessage, OthersMessage }

class MessageItem extends StatelessWidget {
  final MessageType type;
  final String message;
  final DateTime timestamp;
  final bool sent;

  const MessageItem({
    Key? key,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.sent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bubbleColor;
    CrossAxisAlignment alignment;
    if (type == MessageType.MyMessage) {
      bubbleColor = Color(0xFF1FDB5F);
      alignment = CrossAxisAlignment.end;
    } else {
      bubbleColor = Color(0xFFEDF2F6);
      alignment = CrossAxisAlignment.start;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Row(
            mainAxisAlignment: type == MessageType.MyMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${timestamp.hour}:${timestamp.minute}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.withOpacity(0.6),
                ),
              ),
              SizedBox(width: 5),
              if (sent)
                Icon(
                  Icons.done,
                  size: 16,
                  color: Colors.grey.withOpacity(0.6),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
