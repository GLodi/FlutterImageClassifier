import 'package:rxdart/rxdart.dart';

import 'package:flutter_image_classifier/domain/bloc_utils/bloc_utils.dart';
import 'package:flutter_image_classifier/domain/eventstates/camera_event_state.dart';
import 'package:flutter_image_classifier/domain/managers/camera_manager.dart';

class CameraBloc extends BlocEventStateBase<CameraEvent, CameraState> {
  CameraManager _cameraManager;

  final _predictionSubject = BehaviorSubject<String>();
  Stream<String> get prediction => _predictionSubject.stream;

  final _takePhotoSubject = PublishSubject<String>();
  Sink<String> get takePhoto => _takePhotoSubject.sink;

  CameraBloc(this._cameraManager) :
        super(initialState: CameraState.notInitialized());

  void setup() {
    _takePhotoSubject.listen(_takePhoto);
  }

  void _takePhoto(path) {
    _predictionSubject.add("uploading...");
    _cameraManager.uploadImage(path)
        .handleError((e) { _predictionSubject.add("error"); })
        .listen((string) { _predictionSubject.add(string); })
        .asFuture();
  }

  @override
  Stream<CameraState> eventHandler(CameraEvent event, CameraState currentState) async* {
    if (event.type == CameraEventType.start) {
      yield CameraState.notInitialized();
      CameraState result;
      await _cameraManager.getStatus()
          .handleError((e) { result = CameraState.error("Connection error"); })
          .listen((status) { result = CameraState.initialized(status.statusCode.toString()); })
          .asFuture();
      yield result;
    }
  }

}