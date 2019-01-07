import 'package:flutter_image_classifier/domain/bloc_utils/bloc_utils.dart';
import 'package:flutter_image_classifier/domain/eventstates/camera_event_state.dart';
import 'package:flutter_image_classifier/domain/managers/camera_manager.dart';

class CameraBloc extends BlocEventStateBase<CameraEvent, CameraState> {
  CameraManager _cameraManager;

  CameraBloc(this._cameraManager) :
        super(initialState: CameraState.notInitialized());

  @override
  Stream<CameraState> eventHandler(CameraEvent event, CameraState currentState) async* {
    if (event.type == CameraEventType.start) {
      yield CameraState.notInitialized();
      CameraState result;
      await _cameraManager.getAvailability()
          .handleError((e) { result = CameraState.error("errore"); })
          .listen((status) { result = CameraState.initialized(status.statusCode.toString()); })
          .asFuture();
      yield result;
    }
  }

}