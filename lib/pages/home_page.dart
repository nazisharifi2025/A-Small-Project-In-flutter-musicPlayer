import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/model/Song.dart';
import 'package:musicplayer/pages/Song_page.dart';
import 'package:musicplayer/pages/settings.dart';
import 'package:musicplayer/repositories/Song_repositorie.dart';
import 'package:musicplayer/theme_provider.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("playlist", style: GoogleFonts.pacifico(fontSize: 21)),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.music_note), Text("Music Player")],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
          ],
        ),
      ),
      body: MusicPalyList(),
    );
  }
}

Widget MusicPalyList() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GridView.builder(
      itemCount: SongList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final song = SongList[index];
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final radius = BorderRadius.circular(12);
        return Material(
          color: Theme.of(context).colorScheme.surface,
          shadowColor: Colors.black.withValues(alpha: isDark ? 0.45 : 0.50),
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPage(song_Id: song.id),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.black87
                    : Colors.white,
                borderRadius: radius,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      SongList[index].imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SongList[index].singerName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              SongList[index].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
