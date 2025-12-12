import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamController<bool> onlineController = StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((result) {
      onlineController.add(result != ConnectivityResult.none);
    });
  }

  Future<bool> checkOnline() async {
    final res = await _connectivity.checkConnectivity();
    return res != ConnectivityResult.none;
  }

  void dispose() {
    onlineController.close();
  }
}
