import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainScreenState(),
    );
  }
}

class MainScreenState extends StatefulWidget {
  const MainScreenState({super.key});

  @override
  State<MainScreenState> createState() => __MainScreenStateState();
}

class __MainScreenStateState extends State<MainScreenState> {
  int _selectedIndex = 0;
  final List<Widget> _screens =[
    HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}