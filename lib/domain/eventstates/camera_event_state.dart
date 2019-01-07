import 'package:flutter/foundation.dart';

import 'package:flutter_image_classifier/domain/bloc_utils/bloc_event_state.dart';

class CameraState extends BlocState {
  final String message;
  final CameraStateType type;

  CameraState({
    @required this.type,
    this.message,
  });

  factory CameraState.notInitialized() =>
      CameraState(type: CameraStateType.notInitialized);

  factory CameraState.initialized(String message) =>
      CameraState(type: CameraStateType.initialized,
          message: message);

  factory CameraState.error(String message) =>
      CameraState(type: CameraStateType.error,
          message: message);
}

enum CameraStateType {
  initialized,
  notInitialized,
  error,
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