import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:call_apps/services/signaling_service.dart';

class WebRTCService {
  late RTCPeerConnection _peerConnection;
  late MediaStream _localStream;
  late SignalingService _signalingService;
  RTCDataChannel? _dataChannel;

  StreamController<RTCDataChannelMessage> _dataChannelMessageStreamController = StreamController.broadcast();
  Stream<RTCDataChannelMessage> get dataChannelMessages => _dataChannelMessageStreamController.stream;

  WebRTCService(this._signalingService) {
    _initPeerConnection();
  }

  Future<void> _initPeerConnection() async {
    Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        // Tambahkan server TURN jika diperlukan
      ],
    };

    _peerConnection = await createPeerConnection(configuration);

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': false, // Ubah menjadi true jika ingin menggunakan video
    });

    _peerConnection.addStream(_localStream);

    _peerConnection.onIceCandidate = (candidate) {
      _signalingService.sendIceCandidate(candidate.toMap());
    };

    _peerConnection.onIceConnectionState = (state) {
      print("ICE Connection State has changed to $state");
    };

    _initDataChannel();
  }

  Future<void> _initDataChannel() async {
    RTCDataChannelInit dataChannelDict = RTCDataChannelInit();
    _dataChannel = await _peerConnection.createDataChannel('chat', dataChannelDict);

    _dataChannel!.onMessage = (RTCDataChannelMessage message) {
      _dataChannelMessageStreamController.add(message);
    };
  }

  Future<void> createOffer() async {
    RTCSessionDescription description = await _peerConnection.createOffer({'offerToReceiveVideo': true});
    await _peerConnection.setLocalDescription(description);
    _signalingService.sendOffer(description.sdp!); // Pastikan description.sdp tidak null
  }

  Future<void> createAnswer(String? sdp) async {
    if (sdp != null) {
      await _peerConnection.setRemoteDescription(RTCSessionDescription(sdp, 'offer'));
      RTCSessionDescription description = await _peerConnection.createAnswer({'offerToReceiveVideo': true});
      await _peerConnection.setLocalDescription(description);
      _signalingService.sendAnswer(description.sdp!); // Pastikan description.sdp tidak null
    } else {
      print("SDP is null, cannot create answer.");
    }
  }

  void addRemoteDescription(String sdp, String type) async {
    await _peerConnection.setRemoteDescription(RTCSessionDescription(sdp, type));
  }

  void addIceCandidate(RTCIceCandidate candidate) async {
    await _peerConnection.addCandidate(candidate);
  }

  void sendMessage(String message) {
    if (_dataChannel != null) {
      _dataChannel!.send(RTCDataChannelMessage(message));
    }
  }

  Future<void> dispose() async {
    await _dataChannel?.close();
    await _peerConnection.close();
    await _localStream.dispose();
    _dataChannelMessageStreamController.close();
  }
}
