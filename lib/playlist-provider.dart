import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/model/Song.dart';
import 'package:musicplayer/repositories/Song_repositorie.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _PlayList = SongList;

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  int? _currentSongIndex;
  bool _isPlaying = false;

  // Getters
  List<Song> get playList => _PlayList;

  int? get currentSongIndex => _currentSongIndex;

  bool get isPlaying => _isPlaying;

  AudioPlayer get audioPlayer => _audioPlayer;
  // Constractor: listen to audio player state
  PlaylistProvider() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
  }

  // play a song
  Future<void> playSong(int index) async {
    if (index < 0 || index >= _PlayList.length) return;

    _currentSongIndex = index;

    // Replace this with the actual audio or asset path
    final song = _PlayList[index];

    await _audioPlayer.stop();

    await _audioPlayer.play(AssetSource(song.audioUrl));

    notifyListeners();
  }

  // pause song
  Future<void> pauseSong() async {
    await _audioPlayer.pause();
  }

  // Resume song
  Future<void> resumeSong() async {
    await _audioPlayer.resume();
  }

  // Toggel Play/pause
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pauseSong();
    } else if (_currentSongIndex != null) {
      await resumeSong();
    } else if (_PlayList.isNotEmpty) {
      await playSong(0);
    }
  }

  // Play next song
  Future<void> PlayNextSong() async {
    if (_PlayList.isEmpty) return;
  }
}
