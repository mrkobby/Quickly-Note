import 'package:quickly_note/errors/errors.dart';
import 'package:rxdart/rxdart.dart';

class NewNoteBloc {
  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  NewNoteBloc() {
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {}

  void submitError(EntryError error) {
    _errorState$.add(error);
  }
}
