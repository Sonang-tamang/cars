import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<String?> uploadAudio(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    var audioFile = File(filePath);

    if (!(await audioFile.exists())) {
      throw Exception('Audio file does not exist at path: $filePath');
    }

    var audioBytes = await audioFile.readAsBytes();

    request.files.add(http.MultipartFile.fromBytes(
      'audio_file',
      audioBytes,
      filename: 'audio_recording.wav',
      contentType: MediaType('audio', 'wav'),
    ));

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      var responseBody = await streamedResponse.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      print("responds $jsonResponse");
      return jsonResponse['audio_url'];
    } else {
      throw Exception('Failed to upload audio: ${streamedResponse.statusCode}');
    }
  }
}
