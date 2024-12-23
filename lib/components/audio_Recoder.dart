import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class RecorderService {
  FlutterSoundRecorder? _recorder;
  String? _recordingPath;

  RecorderService() {
    _recorder = FlutterSoundRecorder();
  }

  Future<void> initRecorder() async {
    await _recorder!.openRecorder();
    await _setRecordingPath();
  }

  Future<void> _setRecordingPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    _recordingPath = '${directory.path}/audio_recording.wav';
  }

  Future<void> startRecording() async {
    if (_recorder!.isRecording) return;

    await _recorder!.startRecorder(
      toFile: _recordingPath,
      codec: Codec.pcm16WAV,
      sampleRate: 16000,
    );
  }

  Future<String?> stopRecording() async {
    if (!_recorder!.isRecording) return null;

    await _recorder!.stopRecorder();
    return _recordingPath;
  }

  void dispose() {
    _recorder?.closeRecorder();
  }
}
