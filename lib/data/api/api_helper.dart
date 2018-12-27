import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter_image_classifier/data/api/net_utils.dart';

class ApiHelper {
  final url ='https://ineedaprompt.com/dictionary/default/prompt?q=adj+noun+adv+verb+noun+location';
  final NetUtils _net;

  ApiHelper(this._net);

  Future<String> fetchAvailability() async {
    return _net.get(url)
        .then((response) => response.toString())
        .catchError((onError) => 'Error checking availability');
  }

  Future<String> uploadImage(String path) async {
    FormData form = new FormData.from({
      'image' : new UploadFileInfo(new File(path),
          path.substring(path.lastIndexOf('/'), path.length))
    });
    return _net.post(url + '/upload', form)
        .then((response) => response.toString())
        .catchError((onError) => 'Error uploading image');
  }

}