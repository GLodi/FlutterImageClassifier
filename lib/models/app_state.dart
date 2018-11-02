import 'package:meta/meta.dart';
import 'package:flutter_image_classifier/models/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Todo> todos;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState(
      {this.isLoading = false,
      this.todos = const [],
      this.activeTab = AppTab.todos,
      this.activeFilter = VisibilityFilter.all});

  factory AppState.loading() => AppState(isLoading: true);
}