import 'package:flutter/foundation.dart';

import 'package:flutter_image_classifier/domain/bloc_utils/bloc_event_state.dart';

class CameraState extends BlocState {
  final bool isInitialized;

  CameraState({
    @required this.isInitialized,
  });

  factory CameraState.notInitialized() =>
      CameraState(isInitialized: false);

  factory CameraState.initialized() =>
      CameraState(isInitialized: true);
}

class CameraEvent extends BlocEvent {
  final CameraEventType type;

  CameraEvent({
    this.type : CameraEventType.start
  }) : assert(type != null);
}

enum CameraEventType {
  start,
  stop,
}