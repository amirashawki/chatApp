import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frist_project/firebase_options.dart';
import 'package:frist_project/pages/chat_page.dart';
import 'package:frist_project/pages/login_page.dart';
import 'package:frist_project/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  ChatApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}
