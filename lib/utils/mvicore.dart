import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_classifier/repositories/injector.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class MviDisposable {
  Future unsubscribe();
}

abstract class MviView implements MviDisposable {}

class MviPresenter<ViewModel> extends Stream<ViewModel> implements MviDisposable {
  final BehaviorSubject<ViewModel> _subject;
  final List<StreamSubscription<dynamic>> subscriptions = [];
  Injector injector;
  
  MviPresenter({
    @required Stream<ViewModel> stream,
    ViewModel initialModel
  }) : _subject = _createSubject<ViewModel>(stream, initialModel);

  ViewModel get latest => _subject.value;

  void setup() { if(injector != null) injector = Injector(); }

  static _createSubject<ViewState>(Stream<ViewState> model, ViewState initialState) {
    StreamSubscription<ViewState> subscription;
    BehaviorSubject<ViewState> _subject;

    _subject = BehaviorSubject<ViewState>(
      seedValue: initialState,
      onListen: () {
        subscription = model.listen(
          _subject.add,
          onError: _subject.addError,
          onDone: _subject.close
        );
      },
      onCancel: () => subscription.cancel(),
      sync: true
    );

    return _subject;
  }

  @override
  StreamSubscription<ViewModel> listen(
    void Function(ViewModel event) onData, 
    {Function onError, void Function() onDone, bool cancelOnError}
  ) =>
    _subject.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError
    );
  

  @mustCallSuper
  Future unsubscribe() => 
    Future.wait([_subject.close()]..addAll(subscriptions.map((s) => s.cancel())));
  
} 