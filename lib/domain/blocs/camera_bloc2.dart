import 'package:flutter_image_classifier/domain/bloc_utils/bloc_utils.dart';
import 'package:flutter_image_classifier/domain/eventstates/camera_event_state.dart';
import 'package:flutter_image_classifier/domain/managers/camera_manager.dart';

class CameraBloc extends BlocEventStateBase<CameraEvent, CameraState> {
  CameraManager _cameraManager;

  CameraBloc(this._cameraManager) :
        super(initialState: CameraState.notInitialized());

  @override
  Stream<CameraState> eventHandler(CameraEvent event, CameraState currentState) async* {
    if (!currentState.isInitialized) {
      yield CameraState.notInitialized();
    }
    if (event.type == CameraEventType.start) {
      yield CameraState.notInitialized();
      String result;
      await _cameraManager.getAvailability()
          .listen((string) { result = string; })
          .asFuture();
      yield CameraState.initialized(result);
    }
  }

}