import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:flutter_image_classifier/domain/bloc_utils/bloc_utils.dart';
import 'package:flutter_image_classifier/domain/managers/camera_manager.dart';

class CameraBloc extends BlocBase {
  CameraManager _cameraManager;

  // out
  final _availabilitySubject = BehaviorSubject<String>();
  Stream<String> get availability => _availabilitySubject.stream;

  // in
  final _fetchAvailabilitySubject = PublishSubject<int>();
  Sink<int> get fetchAvailability => _fetchAvailabilitySubject.sink;

  CameraBloc(this._cameraManager) {
    _fetchAvailabilitySubject.listen((_) => _fetchAvailability());

    fetchAvailability.add(0);
  }

  void _fetchAvailability() {
    _availabilitySubject.add(null);
    /*
    _cameraManager.getAvailability()
        .map((string) { /*_availabilitySubject.add(string); */})
        .listen((_) => {});
        */

  }

  @override
  void dispose() {
    _availabilitySubject.close();
    _fetchAvailabilitySubject.close();
  }

}