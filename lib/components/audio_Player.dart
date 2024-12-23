import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlaybackService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  File? _tempFile;

  Future<void> playAudioFromUrl(String url) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      _tempFile = File(
          '${tempDir.path}/temp_audio_${DateTime.now().millisecondsSinceEpoch}.wav');
      var response =
          await HttpClient().getUrl(Uri.parse(url)).then((req) => req.close());
      await _tempFile!
          .writeAsBytes(await consolidateHttpClientResponseBytes(response));
      await _audioPlayer.setFilePath(_tempFile!.path);
      await _audioPlayer.play();
    } catch (e) {
      throw Exception('Failed to play audio: $e');
    }
  }

  void dispose() {
    _audioPlayer.dispose();
    _tempFile?.delete().ignore();
  }
}
