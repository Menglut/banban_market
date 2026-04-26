import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  // 기본 더미 데이터
  final List<Map<String, String>> _posts = [
    {
      'category': '반띵 공구',
      'title': '코스트코 생수 1묶음 나눌 분 구해요',
      'location': '도보 5분 거리 (랜덤 위치)',
      'time': '10분 전',
      'icon': '💧',
    },
    {
      'category': '디지털 품앗이',
      'title': '책상 1미터만 옆으로 같이 밀어주실 분',
      'location': '도보 2분 거리 (랜덤 위치)',
      'time': '35분 전',
      'icon': '🤝',
    },
  ];

  List<Map<String, String>> get posts => _posts;

  // 새로운 글을 추가하는 함수 (작동의 핵심!)
  void addPost(String category, String title, String icon) {
    _posts.insert(0, { // 최신 글이 맨 위로 오도록 0번 인덱스에 추가
      'category': category,
      'title': title,
      'location': '내 근처 (랜덤 위치)',
      'time': '방금 전',
      'icon': icon,
    });
    notifyListeners(); // 🌟 화면을 새로고침하라고 앱에 알림 (가장 중요)
  }
}