import 'package:flutter/foundation.dart';

import 'package:flutter_image_classifier/domain/bloc_utils/bloc_event_state.dart';

class CameraState extends BlocState {
  final bool isInitialized;
  final String response;

  CameraState({
    @required this.isInitialized,
    this.response,
  });

  factory CameraState.notInitialized() =>
      CameraState(isInitialized: false);

  factory CameraState.initialized(String response) =>
      CameraState(isInitialized: true, response: response);
}

class CameraEvent extends BlocEvent {
  final CameraEventType type;

  CameraEvent({
    this.type : CameraEventType.start
  }) : assert(type != null);
}

enum CameraEventType {
  start,
}