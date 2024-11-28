import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/user_list_screen.dart';
import 'screens/comment_by_id_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/users': (context) => UserListScreen(),
        '/comments': (context) => CommentByIdScreen(),
      },
    );
  }
}
