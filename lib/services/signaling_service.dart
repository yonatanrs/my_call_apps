import 'dart:convert';
import 'package:web_socket_channel/io.dart';

class SignalingService {
  IOWebSocketChannel? channel;
  String serverUrl;

  SignalingService(this.serverUrl);

  void connect() {
    channel = IOWebSocketChannel.connect(serverUrl);
    channel!.stream.listen(_onMessage);
  }

  void _onMessage(dynamic message) {
    final data = jsonDecode(message);
    switch (data['type']) {
      case 'offer':
      // Panggil fungsi yang menangani offer
        break;
      case 'answer':
      // Panggil fungsi yang menangani answer
        break;
      case 'candidate':
      // Panggil fungsi yang menangani ICE candidate
        break;
      default:
        print('Unknown type ${data['type']}');
    }
  }

  void sendOffer(String sdp) {
    _sendMessage({
      'type': 'offer',
      'sdp': sdp,
    });
  }

  void sendAnswer(String sdp) {
    _sendMessage({
      'type': 'answer',
      'sdp': sdp,
    });
  }

  void sendIceCandidate(Map<String, dynamic> candidate) {
    _sendMessage({
      'type': 'candidate',
      'candidate': candidate,
    });
  }

  void _sendMessage(Map<String, dynamic> message) {
    channel?.sink.add(jsonEncode(message));
  }

  void disconnect() {
    channel?.sink.close();
  }
}
