import 'package:flutter/material.dart';
import 'package:musicplayer/repositories/Song_repositorie.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  final int song_Id;
  SongPage({super.key, required this.song_Id});
  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Song Page")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Expanded(
              flex: 4,

              child: CustomShadow(child: Image.asset(SongList[1].imageUrl)),
            ),
            Column(
              children: [
                Slider(value: 50, min: 0, max: 60, onChanged: (Value) {}),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomShadow(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.skip_previous_rounded),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomShadow(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.play_arrow),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomShadow(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.30 : 0.30),
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.20),
            blurRadius: 1,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      child: child,
    );
  }
}
