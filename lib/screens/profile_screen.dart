import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 3주차 교재 내용: 입력 폼 제어를 위한 컨트롤러 선언
  late TextEditingController _nicknameController;

  // 사용자 데이터 (예시)
  String _currentNickname = "숭실이";
  final String _userGender = "남자"; // 사용자 교정 사항 반영: 한국어 상수 사용
  final double _trustScore = 98.5;

  @override
  void initState() {
    super.initState();
    // 3주차 교재 내용: 위젯 초기화 시 컨트롤러 생성
    _nicknameController = TextEditingController(text: _currentNickname);
  }

  @override
  void dispose() {
    // 3주차 교재 내용: 메모리 누수 방지를 위해 반드시 dispose 호출
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 프로필 헤더 영역
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF72D0B4), // 브랜드 컬러 적용
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),

            // 닉네임 수정 영역
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF72D0B4)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 사용자 정보 카드
            Card(
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text('기본 정보'),
                subtitle: Text('성별: $_userGender | 매너 온도: $_trustScore°C'),
              ),
            ),
            const SizedBox(height: 30),

            // 6주차 교재 내용: 오픈소스 라이선스 고지 버튼
            ListTile(
              title: const Text('오픈소스 라이선스 확인'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Flutter 기본 제공 라이선스 페이지 호출
                showLicensePage(
                  context: context,
                  applicationName: '반쪽장터',
                  applicationVersion: '1.0.0',
                );
              },
            ),
            const Divider(),

            const ListTile(
              title: Text('로그아웃', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}