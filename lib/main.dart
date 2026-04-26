import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:banban_market/screens/home_screen.dart';
import 'package:banban_market/screens/profile_screen.dart';
import 'package:banban_market/screens/map_screen.dart';
import 'package:banban_market/providers/post_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const BanBanApp(),
    ),
  );
}

class BanBanApp extends StatelessWidget {
  const BanBanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '반쪽장터',
      debugShowCheckedModeBanner: false,
      // 3주차 & 7주차 교재 내용: 브랜드 컬러(72D0B4) 테마 적용
      theme: ThemeData(
        primaryColor: const Color(0xFF72D0B4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF72D0B4),
          primary: const Color(0xFF72D0B4),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  // 3주차 교재 내용: 탭 전환을 위한 상태 관리
  int _selectedIndex = 0;

  // 각 탭에 표시될 화면 리스트
  final List<Widget> _pages = [
    const HomeScreen(), // HomeScreen()
    const MapScreen(), // MapScreen()
    const ProfileScreen(), // ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('반쪽장터', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      // 3주차 교재 내용: 레이아웃 위젯 활용
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '안심지도'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내 정보'),
        ],
      ),
    );
  }
}