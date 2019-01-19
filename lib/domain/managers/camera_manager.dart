import 'package:rxdart/rxdart.dart';

import 'package:flutter_image_classifier/data/data.dart';

class CameraManager {
  ApiHelper _api;
  DbHelper _db;

  CameraManager(this._api, this._db);

  Observable<Status> getStatus() =>
      Observable.fromFuture(_api.getStatus())
          .handleError((e) => throw e);

  Observable<String> uploadImage(String path) =>
      Observable.fromFuture(_api.uploadImage(path))
          .handleError((e) => throw e);

}