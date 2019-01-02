import 'package:flutter_image_classifier/domain/bloc_utils/bloc_utils.dart';
import 'package:flutter_image_classifier/domain/eventstates/camera_event_state.dart';

class CameraBloc extends BlocEventStateBase<CameraEvent, CameraState> {

  CameraBloc() : super(initialState : CameraState.notInitialized());

  @override
  Stream<CameraState> eventHandler(CameraEvent event, CameraState currentState) async* {
    if (!currentState.isInitialized) {
      yield CameraState.notInitialized();
    }
    if (event.type == CameraEventType.start) {
      // make network call
    }
    if (event.type == CameraEventType.stop) {
      yield CameraState.initialized();
    }
  }

}