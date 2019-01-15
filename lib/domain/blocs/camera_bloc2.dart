import 'package:rxdart/rxdart.dart';

import 'package:flutter_image_classifier/domain/bloc_utils/bloc_utils.dart';
import 'package:flutter_image_classifier/domain/eventstates/camera_event_state.dart';
import 'package:flutter_image_classifier/domain/managers/camera_manager.dart';

class CameraBloc extends BlocEventStateBase<CameraEvent, CameraState> {
  CameraManager _cameraManager;

  final _availabilitySubject = BehaviorSubject<String>();
  Stream<String> get availability => _availabilitySubject.stream;

  final _fetchAvailabilitySubject = PublishSubject<int>();
  Sink<int> get fetchAvailability => _fetchAvailabilitySubject.sink;

  CameraBloc(this._cameraManager) :
        super(initialState: CameraState.notInitialized());

  @override
  Stream<CameraState> eventHandler(CameraEvent event, CameraState currentState) async* {
    if (event.type == CameraEventType.start) {
      yield CameraState.notInitialized();
      CameraState result;
      await _cameraManager.getAvailability()
          .handleError((e) { result = CameraState.error("Connection error"); })
          .listen((status) { result = CameraState.initialized(status.statusCode.toString()); })
          .asFuture();
      yield result;
    }
  }

}