import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MusicScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MusicScreen();
}

class _MusicScreen extends State<MusicScreen> {
  String state = "init";
  String message = "Press to enjoy...";
  static const MethodChannel _channel = MethodChannel('music_player');
  final String musicUrl =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3";

  Widget _buildButton() {
    Icon a = const Icon(Icons.play_arrow);
    if (state == "play" || state == "init") {
      a = const Icon(Icons.play_arrow);
    } else if (state == "pause") {
      a = const Icon(Icons.pause);
    }

    return ElevatedButton.icon(
      icon: a,
      label: Text(message),
      onPressed: () {
        // button pressed handler
        if (state == "play" || state == "init") {
          playMusic();
          setState(() {
            state = "pause";
            message = "Press to pause";
          });
        } else if (state == "pause") {
          stopMusic();
          setState(() {
            state = "play";
            message = "Press to play";
          });
        }
      },
    );
  }

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
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height * 0.5,
                child: const CircleAvatar(
                  radius: 120,
                  backgroundImage: NetworkImage(
                    'https://themostunrealbeats.files.wordpress.com/2016/03/b8414-avicci2bcarnage.png',
                  ),
                  backgroundColor: Colors.transparent,
                  // add border
                  foregroundColor: Colors.red,
                )),
            Container(
                width: double.infinity, // set container width to screen width
                padding: const EdgeInsets.only(
                    top: 150, left: 10, right: 10, bottom: 20),
                child: _buildButton()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                    icon: const Icon(Icons.repeat, size: 45.0),
                    onPressed: resumeMusic,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                    icon: const Icon(Icons.stop_circle, size: 45.0),
                    onPressed: stopMusic,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
