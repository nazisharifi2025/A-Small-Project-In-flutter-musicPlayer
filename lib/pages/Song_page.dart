import 'package:flutter/material.dart';
import 'package:musicplayer/playlist-provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  final int song_Id;

  const SongPage({super.key, required this.song_Id});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PlaylistProvider>(context, listen: false);

      provider.playSong(widget.song_Id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, Provider, child) {
        final currentIndex = Provider.currentSongIndex;

        final currentSong = currentIndex != null
            ? Provider.playList[currentIndex]
            : Provider.playList[widget.song_Id];

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Now Playing"),
            centerTitle: true,
            elevation: 0,
          ),

          body: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

              child: Column(
                children: [
                  // Album Cover
                  Expanded(
                    flex: 14,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: isDark
                              ? [Colors.grey.shade900, Colors.black]
                              : [Colors.blue.shade100, Colors.blue.shade300],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          currentSong.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Song Information
                  Text(
                    currentSong.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    currentSong.singerName,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),

                  const SizedBox(height: 15),

                  // Progress Slider
                  Slider(
                    value: 50,
                    min: 0,
                    max: 60,
                    activeColor: Colors.blueAccent,
                    onChanged: (value) {},
                  ),

                  const Spacer(),

                  // Music Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.playPreviusSong();
                        },
                        icon: const Icon(Icons.skip_previous_rounded, size: 35),
                      ),

                      const SizedBox(width: 25),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withValues(alpha: 0.35),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            Provider.togglePlayPause();
                          },
                          icon: Icon(
                            Provider.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),
                      ),

                      const SizedBox(width: 25),

                      IconButton(
                        onPressed: () {
                          Provider.PlayNextSong();
                        },
                        icon: const Icon(Icons.skip_next_rounded, size: 35),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
