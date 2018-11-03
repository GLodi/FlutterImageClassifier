import 'package:flutter_image_classifier/models/app_state.dart';
import 'package:flutter_image_classifier/reducers/counter_reducer.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
      isLoading: false,
      count: counterReducer(state.count, action),
  );
}

