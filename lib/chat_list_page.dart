import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'chat_item.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<String> _users = [
    'Виктор Власов',
  ];

  //ДЛЯ ОТОБРАЖЕНИЯ ПОСЛЕДНЕГО СООБЩЕНИЯ
  Map<String, String> _lastMessages = {
    'Виктор Власов': '',
  };
  void updateLastMessage(String userName, String message) {
    setState(() {
      _lastMessages[userName] = message;
    });
  }

//ДЛЯ ОТОБРАЖЕНИЯ ВРЕМЕНИ ПОСЛЕДНЕГО СООБЩЕНИЯ
  Map<String, String> _lastMessagesTime = {
    'Виктор Власов': '',
  };
  void updateLastMessageTime(String userName, String time) {
    setState(() {
      _lastMessagesTime[userName] = time;
    });
  }

  List<String> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers.addAll(_users);
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = _users
          .where((user) => user.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Чаты', style: TextStyle(fontSize: 32)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 42,
            width: 335,
            decoration: BoxDecoration(
              color: Color(0xFFEDF2F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Color(0xFF9DB7CB)),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: _filterUsers,
                    decoration: InputDecoration(
                      hintText: 'Поиск',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xFF9DB7CB)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length,
              itemBuilder: (context, index) {
                final userName = _filteredUsers[index];
                final lastMessage = _lastMessages[userName] ?? '';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          userName: _filteredUsers[index],
                          iconData: Icons.account_circle,
                          iconColor: Colors.blue,
                          updateLastMessage: updateLastMessage,
                          updateLastMessageTime: updateLastMessageTime,
                        ),
                      ),
                    );
                  },
                  child: ChatItem(
                    userName: _filteredUsers[index],
                    lastMessage: lastMessage,
                    lastMessageTime: _formatTime(
                        _lastMessagesTime[_filteredUsers[index]] ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//ФОРМАТ ВРЕМЕНИ НА ЧАСЫ И МИНУТЫ
String _formatTime(String? time) {
  if (time == null || time.isEmpty) {
    return '';
  }

  final dateTime = DateTime.parse(time);
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');

  return '$hour:$minute';
}
