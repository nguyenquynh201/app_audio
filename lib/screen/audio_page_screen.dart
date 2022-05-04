import 'package:ebook_audio/constant/assets_image/asset_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPageScreen extends StatefulWidget {
  const AudioPageScreen({Key? key, required this.audioPlayer, required this.audioPath})
      : super(key: key);
  final AudioPlayer audioPlayer;
  final String audioPath;

  @override
  State<AudioPageScreen> createState() => _AudioPageScreenState();
}

class _AudioPageScreenState extends State<AudioPageScreen> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;
  bool isPause = false;
  bool isRepeat = false;
  Color color = Colors.black;
  final List<IconData> _icon = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        _duration = event;
        print(event);
      });
      widget.audioPlayer.onAudioPositionChanged.listen((event) {
       setState(() {
         _position = event;
       });
      });
    });
    widget.audioPlayer.setUrl(widget.audioPath);
    widget.audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isRepeat = false;
          isPlaying = false;
        }
      });
    });
  }

  Widget btnStart() {
    return IconButton(
        onPressed: () async{
          if (isPlaying == false) {
           int result = await widget.audioPlayer.play(widget.audioPath, isLocal: false,);
           if (result == 1) {
             print('success');
           }
            setState(() {
              isPlaying = true;
            });
          } else if (isPlaying == true) {
            widget.audioPlayer.pause();
            setState(() {
              isPlaying = false;
            });
          }
        },
        padding: const EdgeInsets.only(bottom: 10),
        icon: isPlaying == false
            ? Icon(_icon[0], size: 50, color: Colors.blue)
            : Icon(_icon[1], size: 50, color: Colors.blue));
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          widget.audioPlayer.setPlaybackRate(1.5);
        },
        icon: ImageIcon(AssetImage(AssetImages.forword),
            size: 15, color: Colors.black));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          widget.audioPlayer.setPlaybackRate(0.5);
        },
        icon: ImageIcon(AssetImage(AssetImages.backword),
            size: 15, color: Colors.black));
  }

  Widget btnLoop() {
    return IconButton(
        onPressed: () {},
        icon: ImageIcon(AssetImage(AssetImages.loop),
            size: 15, color: Colors.black));
  }

  Widget btnRepeat() {
    return IconButton(
        onPressed: () {
          if (isRepeat == false) {
            widget.audioPlayer.setReleaseMode(ReleaseMode.LOOP);
            setState(() {
              isRepeat = true;
              color = Colors.blue;
            });
          } else if (isRepeat == true) {
            widget.audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
            isRepeat = false;
            color = Colors.black;
          }
        },
        icon:
            ImageIcon(AssetImage(AssetImages.repeat), size: 15, color: color));
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        min: 0.0,
        max: 100,
        value: _position.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.audioPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [btnRepeat(), btnSlow(), btnStart(), btnFast(), btnLoop()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),Text(
                  _duration.toString().split(".")[0],
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          slider(),
          loadAsset()
        ],
      ),
    );
  }
}
