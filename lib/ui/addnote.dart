import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly_note/bloc/addnote_bloc.dart';
import 'package:quickly_note/bloc/global_bloc.dart';
import 'package:quickly_note/errors/errors.dart';
import 'package:quickly_note/models/notes.dart';
import 'package:quickly_note/ui/success.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController;
  TextEditingController bodyController;
  NewNoteBloc _newNoteBloc;

  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
    _newNoteBloc.dispose();
  }

  void initState() {
    super.initState();
    _newNoteBloc = NewNoteBloc();
    titleController = TextEditingController();
    bodyController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () {
              String title;
              String body;

              if (titleController.text == "") {
                _newNoteBloc.submitError(EntryError.TitleNull);
                return;
              }
              if (titleController.text != "") {
                title = titleController.text;
              }
              if (bodyController.text == "") {
                _newNoteBloc.submitError(EntryError.BodyNull);
                return;
              }
              if (bodyController.text != "") {
                body = bodyController.text;
              }
              List<int> noteIDs = makeIDs(12.43);

              Note newEntryNote = Note(
                noteIDs: noteIDs,
                title: title,
                body: body,
              );

              _globalBloc.updateNotesList(newEntryNote);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Success();
                  },
                ),
              );
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
        centerTitle: false,
        title: Text(
          "Add New Note",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.black87,
        child: Provider<NewNoteBloc>.value(
          value: _newNoteBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              PanelTitle(
                title: "Title",
                isRequired: true,
              ),
              TextFormField(
                maxLength: 50,
                style: TextStyle(fontSize: 16, color: Colors.grey),
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              PanelTitle(
                title: "Body",
                isRequired: true,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                style: TextStyle(fontSize: 16, color: Colors.grey),
                controller: bodyController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newNoteBloc.errorState$.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.TitleNull:
            displayError("Please enter the title");
            break;
          case EntryError.BodyNull:
            displayError("Please fill body field");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[300],
        content: Text(error),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ),
        ]),
      ),
    );
  }
}
