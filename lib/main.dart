import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'chat_list_page/chat_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA0BQvKKhnHgYhEHh15Grg5vhYJo3bECnY",
          appId: "186919126975",
          messagingSenderId: "1:186919126975:android:8ffc6625dc94bfce88430a",
          projectId: "chattingapp-cb568"));
  runApp(ChatApp());
}
