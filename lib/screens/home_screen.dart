import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:banban_market/providers/post_provider.dart';
import 'package:banban_market/screens/write_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🌟 Provider에서 실시간 데이터를 가져옵니다.
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          final post = postProvider.posts[index];

          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF72D0B4).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text(post['icon']!, style: const TextStyle(fontSize: 24))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['category']!, style: const TextStyle(fontSize: 12, color: Color(0xFF72D0B4), fontWeight: FontWeight.bold)),
                        Text(post['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${post['location']} • ${post['time']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // 플로팅 버튼을 누르면 글쓰기 화면으로 이동합니다!
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WriteScreen()),
          );
        },
        backgroundColor: const Color(0xFF72D0B4),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}