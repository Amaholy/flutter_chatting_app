import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_item.dart';

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
  final Function(String, String) updateLastMessage;
  final Function(String, String) updateLastMessageTime;

  ChatPage({
    required this.userName,
    required this.iconData,
    required this.iconColor,
    required this.updateLastMessage,
    required this.updateLastMessageTime,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();

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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Ошибка: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageItem(
                      type: MessageType.MyMessage,
                      message: message['text'],
                      timestamp: message['timestamp'].toDate(),
                      sent: message['sent'],
                    );
                  },
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
                      // Обработка вложений файлов
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
                        contentPadding: EdgeInsets.only(left: 10, bottom: 10),
                        hintText: 'Сообщение',
                        hintStyle: TextStyle(color: Color(0xFF9DB7CB)),
                        border: InputBorder.none,
                      ),
                      onSubmitted: _sendMessage,
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
      FirebaseFirestore.instance.collection('messages').add({
        'text': text,
        'timestamp': DateTime.now(),
        'sent': true,
      });

      widget.updateLastMessage(widget.userName, text);
      widget.updateLastMessageTime(widget.userName, DateTime.now().toString());
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
