import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Model for educational content
class LearningModule {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final int rewardTokens;
  bool isCompleted;

  LearningModule({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.rewardTokens,
    this.isCompleted = false,
  });
}

class GamifiedLearningScreen extends StatefulWidget {
  @override
  _GamifiedLearningScreenState createState() => _GamifiedLearningScreenState();
}

class _GamifiedLearningScreenState extends State<GamifiedLearningScreen> {
  int totalTokens = 0;
  late List<LearningModule> modules;

  @override
  void initState() {
    super.initState();
    _loadTokens();
    _initializeModules();
  }

  void _initializeModules() {
    modules = [
      LearningModule(
        id: '1',
        title: 'Understanding Your Cycle',
        description: 'Learn about the menstrual cycle and its phases.',
        videoUrl: 'assets/videos/cycle.mp4',
        rewardTokens: 50,
      ),
      LearningModule(
        id: '2',
        title: 'Healthy Lifestyle Habits',
        description: 'Tips for maintaining a healthy lifestyle.',
        videoUrl: 'assets/videos/lifestyle.mp4',
        rewardTokens: 30,
      ),
      // Add more modules as needed
    ];
  }

  Future<void> _loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalTokens = prefs.getInt('tokens') ?? 0;
    });
  }

  Future<void> _saveTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tokens', totalTokens);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VnHOPE Learning'),
        backgroundColor: Color(0xFF90EE90),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.token, color: Colors.amber),
                SizedBox(width: 4),
                Text(
                  '$totalTokens',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final module = modules[index];
          return _buildModuleCard(module);
        },
      ),
    );
  }

  Widget _buildModuleCard(LearningModule module) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.grey[200],
                child: Icon(Icons.play_circle_outline, size: 50),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  module.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.token, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          '${module.rewardTokens} tokens',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: module.isCompleted
                          ? null
                          : () => _openVideoPlayer(module),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF90EE90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        module.isCompleted ? 'Completed' : 'Start Learning',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openVideoPlayer(LearningModule module) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          module: module,
          onVideoCompleted: () => _handleVideoCompletion(module),
        ),
      ),
    );
  }

  void _handleVideoCompletion(LearningModule module) {
    if (!module.isCompleted) {
      setState(() {
        module.isCompleted = true;
        totalTokens += module.rewardTokens;
      });
      _saveTokens();
      _showRewardDialog(module.rewardTokens);
    }
  }

  void _showRewardDialog(int tokens) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Congratulations! 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events, size: 50, color: Colors.amber),
            SizedBox(height: 16),
            Text('You\'ve earned $tokens tokens!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Continue Learning'),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final LearningModule module;
  final VoidCallback onVideoCompleted;

  VideoPlayerScreen({
    required this.module,
    required this.onVideoCompleted,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.module.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
      })
      ..addListener(() {
        if (_controller.value.position >= _controller.value.duration) {
          widget.onVideoCompleted();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.title),
        backgroundColor: Color(0xFF90EE90),
      ),
      body: Center(
        child: _isVideoInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}