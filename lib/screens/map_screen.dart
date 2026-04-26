import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // 기준 동네 좌표 (숭실대학교 부근)
  final LatLng _center = const LatLng(37.4963, 126.9573);
  List<Marker> _randomMarkers = [];

  // 카테고리별 상세 요청 내용
  final List<String> _poomassiRequests = [
    '벌레 잡아주세요 (다급) 🪳',
    '전구 교체 5분컷 도와주세요 💡',
    '책상 1미터만 같이 옮겨주실 분 🤝',
    '노트북 충전기 1시간만 빌려주실 분 🔌'
  ];

  final List<String> _gongguRequests = [
    '양배추 반 통 나누실 분 🥬',
    '코스트코 생수 반띵 하실 분 💧',
    '배달비 아끼실 분! 치킨 같이 시켜요 🍗',
    '수박 한 통 너무 커요.. 반만 가져가실 분 🍉'
  ];

  @override
  void initState() {
    super.initState();
    _generateSafeMarkers();
  }

  void _generateSafeMarkers() {
    final random = Random();
    List<Marker> tempMarkers = [];

    for (int i = 0; i < 6; i++) {
      // 프라이버시 보호를 위해 무작위 근사치 위치 생성
      double latOffset = (random.nextDouble() - 0.5) * 0.008;
      double lngOffset = (random.nextDouble() - 0.5) * 0.008;
      LatLng randomPos = LatLng(_center.latitude + latOffset, _center.longitude + lngOffset);

      // 카테고리 결정
      bool isPoomassi = random.nextBool();
      String category = isPoomassi ? '디지털 품앗이' : '반띵 공구';
      String title = isPoomassi
          ? _poomassiRequests[random.nextInt(_poomassiRequests.length)]
          : _gongguRequests[random.nextInt(_gongguRequests.length)];

      tempMarkers.add(
        Marker(
          point: randomPos,
          width: 100, // 라벨 길이를 고려하여 폭 조절
          height: 80,
          child: GestureDetector(
            onTap: () => _showMarkerDetailSheet(context, category, title),
            child: Column(
              children: [
                const Icon(
                    Icons.location_on,
                    color: Color(0xFF72D0B4), // 브랜드 전용 민트색 적용
                    size: 40
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF72D0B4), width: 1),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Text(
                    category, // 마커 라벨에 카테고리 표시
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    setState(() {
      _randomMarkers = tempMarkers;
    });
  }

  void _showMarkerDetailSheet(BuildContext context, String category, String title) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                category,
                style: const TextStyle(
                  color: Color(0xFF72D0B4),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.security, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '안심 보호를 위해 대략적인 위치로 표시됩니다.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF72D0B4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('이웃에게 매칭 요청을 보냈습니다!')),
                    );
                  },
                  child: const Text(
                      '도와주기 (매칭 요청)',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _center,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.banban_market',
          ),
          MarkerLayer(markers: _randomMarkers),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateSafeMarkers,
        backgroundColor: const Color(0xFF72D0B4),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}