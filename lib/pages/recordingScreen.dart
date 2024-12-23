// ignore_for_file: prefer_const_constructors

import 'package:cars/components/audio_API.dart';
import 'package:cars/components/audio_Player.dart';
import 'package:cars/components/audio_Recoder.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class Recording extends StatefulWidget {
  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  final RecorderService _recorderService = RecorderService();
  final AudioPlaybackService _audioPlaybackService = AudioPlaybackService();
  final ApiService _apiService =
      ApiService('https://voiceassistant.goodwish.com.np/chatbot/response/');
  bool isRecording = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _recorderService.initRecorder();
  }

  Future<void> _requestPermissions() async {
    var micPermission = await Permission.microphone.request();
    var storagePermission = await Permission.storage.request();

    if (micPermission.isDenied || storagePermission.isDenied) {
      if (micPermission.isPermanentlyDenied ||
          storagePermission.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  Future<void> startRecording() async {
    await _requestPermissions();
    if (isRecording) return;

    try {
      await _recorderService.startRecording();
      setState(() => isRecording = true);
    } catch (e) {
      _showSnackbar('Failed to start recording: $e');
    }
  }

  Future<void> stopRecordingAndSend() async {
    if (!isRecording) return;

    try {
      String? recordingPath = await _recorderService.stopRecording();
      setState(() => isRecording = false);

      if (recordingPath != null) {
        setState(() => isLoading = true);
        String? audioUrl = await _apiService.uploadAudio(recordingPath);
        if (audioUrl != null) {
          await _audioPlaybackService.playAudioFromUrl(audioUrl);
        } else {
          _showSnackbar('No audio URL returned from server.');
        }
      }
    } catch (e) {
      _showSnackbar('Failed to process recording: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _recorderService.dispose();
    _audioPlaybackService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? Text("thinking")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mic, size: 80, color: Colors.red),
                  Text(
                    isRecording ? "Recording..." : "Press to record",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed:
                        isRecording ? stopRecordingAndSend : startRecording,
                    child: Text(
                        isRecording ? "Stop & Send Sound" : "Ready to Record"),
                  ),
                ],
              ),
      ),
    );
  }
}
