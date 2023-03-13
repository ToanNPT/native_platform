import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MusicPlayerScreen(
    musicUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
  ));
}

const MethodChannel _channel = MethodChannel('music_player');

class MusicPlayerScreen extends StatelessWidget {
  final String musicUrl;

  MusicPlayerScreen({required this.musicUrl});

  void playMusic() async {
    try {
      await _channel.invokeMethod('play', {'url': musicUrl});
    } on PlatformException catch (e) {
      print("Error playing music: ${e.message}");
    }
  }

  void pauseMusic() async {
    try {
      await _channel.invokeMethod('pause');
    } on PlatformException catch (e) {
      print("Error pause music: ${e.message}");
    }
  }

  void resumeMusic() async {
    try {
      await _channel.invokeMethod('resume');
    } on PlatformException catch (e) {
      print("Error resume music: ${e.message}");
    }
  }

  void stopMusic() async {
    try {
      await _channel.invokeMethod('stop');
    } on PlatformException catch (e) {
      print("Error stopping music: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Music Player'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize: 60,
                icon: Icon(Icons.play_arrow),
                onPressed: playMusic,
              ),
              IconButton(
                iconSize: 60,
                icon: Icon(Icons.pause),
                onPressed: pauseMusic,
              ),
              IconButton(
                iconSize: 50,
                icon: Icon(Icons.circle),
                onPressed: resumeMusic,
              ),
              IconButton(
                iconSize: 60,
                icon: Icon(Icons.stop),
                onPressed: stopMusic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
