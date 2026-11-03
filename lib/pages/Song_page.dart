// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:musicplayer/playlist-provider.dart';
// import 'package:musicplayer/repositories/Song_repositorie.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  final int song_Id;
  SongPage({super.key, required this.song_Id});
  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  void initState() {
    super.initState();

    // Start playing the selected song after the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PlaylistProvider>(context, listen: false);

      provider.playSong(widget.song_Id);
    });
  }

  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, Provider, child) {
        final currentIndex = Provider.currentSongIndex;

        final currentSong = currentIndex != null
            ? Provider.playList[currentIndex]
            : Provider.playList[widget.song_Id];

        return Scaffold(
          appBar: AppBar(title: Text("Song Page")),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Expanded(
                  flex: 4,

                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: CustomShadow(
                      child: Image.asset(
                        currentSong.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  currentSong.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Slider(value: 50, min: 0, max: 60, onChanged: (Value) {}),
                    Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomShadow(
                            child: IconButton(
                              onPressed: () {
                                Provider.playPreviusSong();
                              },
                              icon: Icon(Icons.skip_previous_rounded),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: CustomShadow(
                            child: IconButton(
                              onPressed: () {
                                Provider.togglePlayPause();
                              },
                              icon: Icon(
                                Provider.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomShadow(
                            child: IconButton(
                              onPressed: () {
                                Provider.PlayNextSong();
                              },
                              icon: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomShadow extends StatelessWidget {
  final Widget child;
  CustomShadow({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 1,
              offset: Offset(4, 4),
            ),
            // BoxShadow(
            //   color: Colors.grey.shade500,
            //   blurRadius: 1,
            //   offset: Offset(-4, -4),
            // ),
          ],
        ),
        child: child,
      ),
    );
  }
}
