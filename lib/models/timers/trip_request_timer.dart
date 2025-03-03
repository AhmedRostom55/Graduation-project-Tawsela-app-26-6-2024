import 'dart:async';

import '../../app_logger.dart';

class TripRequestTimer {
  Timer? _requestTimer;
  Timer? _tripTimer;
  final Future<void> Function() tripCallback;
  final Future<void> Function() requestCallback;
  Duration duration;

  TripRequestTimer({
    required this.requestCallback,
    required this.tripCallback,
    required this.duration,
  });

  bool isRequestTimerOn() {
    if (_requestTimer == null) {
      return false;
    }
    return _requestTimer!.isActive;
  }

  bool isTripTimerOn() {
    if (_tripTimer == null) {
      return false;
    }
    return _tripTimer!.isActive;
  }

  void startTripTimer() {
    _tripTimer = Timer.periodic(duration, (timer) async {
      try {
        await tripCallback();
      } catch (error) {
        AppLogger.log('Error in trip timer');
      }
    });
  }

  void startRequestTimer() {
    _requestTimer = Timer.periodic(duration, (timer) async {
      try {
        await requestCallback();
      } catch (error) {
        AppLogger.log('Error in request timer');
      }
    });
  }

  void stopTripTimer() {
    if (_tripTimer != null) {
      _tripTimer!.cancel();
    }
  }

  void stopRequestTimer() {
    if (_requestTimer != null) {
      _requestTimer!.cancel();
    }
  }
}