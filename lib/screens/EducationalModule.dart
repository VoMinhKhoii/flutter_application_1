import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/VideoPlayerScreen.dart';


class EducationalModule extends StatelessWidget {
  final Function(int) onVideoCompleted; // Callback to reward tokens

  EducationalModule({required this.onVideoCompleted});

  final List<Map<String, String>> videos = [
    {'title': 'Menstrual Health Basics', 'url': 'https://example.com/video1'},
    {'title': 'Track Your Cycle', 'url': 'https://example.com/video2'},
    {'title': 'Common Reproductive Issues', 'url': 'https://example.com/video3'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(16),
          child: ListTile(
            leading: Icon(Icons.play_circle_fill, size: 40, color: Colors.green),
            title: Text(videos[index]['title']!),
            trailing: ElevatedButton(
              onPressed: () {
                // Simulate video completion
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerScreen(
                      videoUrl: videos[index]['url']!,
                      onVideoCompleted: () => onVideoCompleted(10), // Reward 10 tokens
                    ),
                  ),
                );
              },
              child: Text('Watch'),
            ),
          ),
        );
      },
    );
  }
}
