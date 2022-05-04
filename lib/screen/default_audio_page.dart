import 'package:ebook_audio/constant/ui_color.dart';
import 'package:ebook_audio/screen/audio_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultAudioPageScreen extends StatefulWidget {
  final booksData;
  final int index;

  const DefaultAudioPageScreen(
      {Key? key, required this.booksData, required this.index})
      : super(key: key);

  @override
  State<DefaultAudioPageScreen> createState() => _DefaultAudioPageScreenState();
}

class _DefaultAudioPageScreenState extends State<DefaultAudioPageScreen> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();

  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: UIColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: screenHeight / 3,
              child: Container(
                color: UIColors.audioBlueBackground,
              )),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                ],
                backgroundColor: Colors.transparent,
                elevation: 0,
              )),
          Positioned(
              top: screenHeight * 0.2,
              left: 0,
              height: screenHeight * 0.45,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                       20)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.booksData[widget.index]['title'],
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      Text(widget.booksData[widget.index]['text'],
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                     AudioPageScreen(audioPlayer: audioPlayer , audioPath: widget.booksData[widget.index]['audio'])
                    ],
                  ),
                ),
              )),
          Positioned(
              top: screenHeight * 0.12,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              child: Container(
                height: screenHeight / 6,
                decoration: BoxDecoration(
                  color: UIColors.audioGreyBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: AssetImage(
                                widget.booksData[widget.index]['img']),
                            fit: BoxFit.cover)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
