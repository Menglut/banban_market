import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:banban_market/providers/post_provider.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedCategory = '디지털 품앗이';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도움 요청하기'),
        backgroundColor: const Color(0xFF72D0B4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 카테고리 선택
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: '카테고리'),
              items: ['디지털 품앗이', '반띵 공구'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),

            // 제목 입력
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '어떤 도움이 필요하신가요?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // 등록 버튼
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF72D0B4),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  // 아이콘 자동 지정
                  String icon = _selectedCategory == '반띵 공구' ? '📦' : '🤝';

                  // Provider를 통해 새 글 추가!
                  Provider.of<PostProvider>(context, listen: false)
                      .addPost(_selectedCategory, _titleController.text, icon);

                  // 홈 화면으로 돌아가기
                  Navigator.pop(context);
                }
              },
              child: const Text('등록하기', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}