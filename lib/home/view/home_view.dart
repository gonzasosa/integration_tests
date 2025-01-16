import 'package:flutter/material.dart';
import 'package:integration_tests/comments/view/comments_page.dart';
import 'package:integration_tests/utils/dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;

  final _pages = [
    CommentsPage(),
    Scaffold(
      body: Text('ENV'),
    ),
    Scaffold(
      body: Text('Settings'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          late final String title;
          switch (value) {
            case 0:
              title = 'Awesome!';
              break;
            case 1:
              title = const String.fromEnvironment('ENV_VAR');
              break;
            case 2:
              title = 'Great!';
              break;
          }
          setState(() => _index = value);
          CustomDialog.show(context, title: title);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Comments',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Env Var',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
