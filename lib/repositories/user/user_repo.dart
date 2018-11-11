import 'package:flutter_image_classifier/models/user.dart';

abstract class UserRepo {

  Future<User> login();

}