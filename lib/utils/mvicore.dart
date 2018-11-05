import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

abstract class MviView {
  Future closeSubscriptions();
}

class MviPresenter<ViewModel> extends Stream<ViewModel> implements MviView {
  final BehaviorSubject<ViewModel> _subject;
  
  MviPresenter({@required Stream<ViewModel> stream, ViewModel initialModel}) : _subject = _createSubject<ViewModel>(stream, initialModel);

  static _createSubject<ViewState>( Stream<ViewState> model, ViewState initialState) {

  }

  @override
  Future closeSubscriptions() {
    // TODO: implement closeSubscriptions
  }

  @override
  StreamSubscription<ViewModel> listen(void Function(ViewModel event) onData, {Function onError, void Function() onDone, bool cancelOnError}) {
    // TODO: implement listen
  }
  
} 