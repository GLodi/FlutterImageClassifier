import 'package:rxdart/rxdart.dart';

import 'package:flutter_image_classifier/data/data.dart';

class CameraManager {
  ApiHelper _api;
  DbHelper _db;

  CameraManager(this._api, this._db);

  Observable<String> getAvailability() =>
      Observable.fromFuture(_api.fetchAvailability())
          .handleError((e) => throw e );

}