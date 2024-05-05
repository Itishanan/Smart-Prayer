import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChildActivities extends StatefulWidget {
  const ChildActivities({super.key});

  @override
  _ChildActivitiesState createState() => _ChildActivitiesState();
}
class _ChildActivitiesState extends State<ChildActivities> {
  List<String> _videoUrls = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _fetchVideos();
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing: $e");
      }
    }
  }

  Future<void> _fetchVideos() async {
    try {
      // Fetch video URLs from Firebase Storage
      List<String> firebaseVideos = await _loadFirebaseVideos();
      _videoUrls = firebaseVideos;
      setState(() {
        _isLoading = false; // Set loading state to false when videos are fetched
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching videos: $e");
      }
      setState(() {
        _isLoading = false; // Set loading state to false when error occurs
        _errorMessage = 'Error fetching videos: $e'; // Set error message
      });
    }
  }

  Future<List<String>> _loadFirebaseVideos() async {
    // Fetch video URLs from Firebase Storage
    try {
      final List<String> videoUrls = [];
      // Create a reference to the folder containing your videos
      final Reference folderRef = FirebaseStorage.instance.ref().child('Videos');
      // List all items (videos) in the folder
      final ListResult result = await folderRef.listAll();
      // Iterate over each item and fetch the download URL
      for (final Reference ref in result.items) {
        final String url = await ref.getDownloadURL();
        videoUrls.add(url);
        print('Video URL: $url');
      }
      return videoUrls;
    } catch (e) {
      throw Exception("Failed to load Firebase videos: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Activities'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _errorMessage != null
          ? Center(
        child: Text(_errorMessage!),
      )
          : _videoUrls.isNotEmpty
          ? ListView.builder(
        itemCount: _videoUrls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Video ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(videoUrl: _videoUrls[index]),
                ),
              );
            },
          );
        },
      )
          : const Center(
        child: Text('No videos found'),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;


   VideoPlayerScreen({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;


  const _ControlsOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                color: Colors.white,
                iconSize: 80.0,
                onPressed: () {
                  controller.play();
                },
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: VideoProgressIndicator(
            controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.blueAccent,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 8,
          child: Text(
            '${_formatDuration(controller.value.position)} / ${_formatDuration(controller.value.duration)}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child:IconButton(
            icon: const Icon(Icons.fullscreen),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}