import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_image_classifier/data/api/net_utils.dart';

class ApiHelper {
  final url ='http://192.168.1.9:5000';
  final NetUtils _net;

  ApiHelper(this._net);

  Future<String> fetchAvailability() async {
    return _net.get(url)
        .then((response) => response.toString())
        .catchError((e) => throw e);
  }

  Future<String> uploadImage(String path) async {
    FormData form = new FormData.from({
      'file' : new UploadFileInfo(new File(path),
          path.substring(path.lastIndexOf('/'), path.length))
    });
    return _net.post(url + '/predict', form)
        .then((response) => response.toString())
        .catchError((e) => throw e);
  }

}