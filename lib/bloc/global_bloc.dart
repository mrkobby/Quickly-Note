import 'dart:convert';

import 'package:quickly_note/models/notes.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  BehaviorSubject<List<Note>> _noteList$;
  BehaviorSubject<List<Note>> get noteList$ => _noteList$;

  GlobalBloc() {
    _noteList$ = BehaviorSubject<List<Note>>.seeded([]);
    makeNoteList();
  }

  Future removeNote(Note quickRemoved) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> noteJsonList = [];

    var blocList = _noteList$.value;
    blocList.removeWhere((note) => note.title == quickRemoved.title);

    if (blocList.length != 0) {
      for (var blocNote in blocList) {
        String noteJson = jsonEncode(blocNote.toJson());
        noteJsonList.add(noteJson);
      }
    }
    sharedUser.setStringList('notes', noteJsonList);
    _noteList$.add(blocList);
  }

  Future makeNoteList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> jsonList = sharedUser.getStringList('notes');
    List<Note> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonNote in jsonList) {
        Map userMap = jsonDecode(jsonNote);
        Note tempNote = Note.fromJson(userMap);
        prefList.add(tempNote);
      }
      _noteList$.add(prefList);
    }
  }

  Future updateNotesList(Note newNote) async {
    var blocList = _noteList$.value;
    blocList.add(newNote);
    _noteList$.add(blocList);
    Map<String, dynamic> tempMap = newNote.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newNoteJson = jsonEncode(tempMap);
    List<String> noteJsonList = [];
    if (sharedUser.getStringList('notes') == null) {
      noteJsonList.add(newNoteJson);
    } else {
      noteJsonList = sharedUser.getStringList('notes');
      noteJsonList.add(newNoteJson);
    }
    sharedUser.setStringList('notes', noteJsonList);
  }

  void dispose() {
    _noteList$.close();
  }
}
