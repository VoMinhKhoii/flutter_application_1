import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final VoidCallback onVideoCompleted;

  VideoPlayerScreen({required this.videoUrl, required this.onVideoCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: Column(
        children: [
          // Replace this Container with an actual video player widget
          Container(
            height: 200,
            color: Colors.black,
            alignment: Alignment.center,
            child: Text('Video Player Placeholder', style: TextStyle(color: Colors.white)),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              onVideoCompleted(); // Trigger token reward
              Navigator.pop(context); // Return to the video list
            },
            child: Text('Finish Watching'),
          ),
        ],
      ),
    );
  }
}
