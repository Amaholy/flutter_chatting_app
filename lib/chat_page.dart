import 'package:flutter/material.dart';
import 'message_item.dart';
import 'chat_item.dart';

class ChatMessage {
  final String text;
  final DateTime timestamp;
  final bool sent;

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.sent,
  });
}

class ChatPage extends StatefulWidget {
  final String userName;
  final IconData iconData;
  final Color iconColor;

  ChatPage(
      {required this.userName,
      required this.iconData,
      required this.iconColor});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.iconColor,
              ),
              child: Center(
                child: Icon(
                  widget.iconData,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'В сети',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageItem(
                  type: _messages[index].sent
                      ? MessageType.MyMessage
                      : MessageType.OthersMessage,
                  message: _messages[index].text,
                  timestamp: _messages[index].timestamp,
                  sent: _messages[index].sent,
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDF2F6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.black),
                    onPressed: () {
                      // Handle file attachment
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF2F6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Сообщение',
                        hintStyle: TextStyle(color: Color(0xFF9DB7CB)),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (text) {
                        _sendMessage(text);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDF2F6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.black),
                    onPressed: () {
                      _sendMessage(_messageController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: text,
            timestamp: DateTime.now(),
            sent: true,
          ),
        );
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
