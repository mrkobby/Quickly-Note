import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly_note/bloc/global_bloc.dart';
import 'package:quickly_note/models/notes.dart';

class NoteDetails extends StatelessWidget {
  final Note note;

  NoteDetails(this.note);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            onPressed: () {
              openAlertBox(context, _globalBloc);
            },
          )
        ],
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
        centerTitle: false,
        title: Text(
          "Note",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              ExtendedSection(note: note),
            ],
          ),
        ),
      ),
    );
  }

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            contentPadding: EdgeInsets.all(10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        "Delete this note?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _globalBloc.removeNote(note);
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName('/'),
                          );
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0)),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class ExtendedSection extends StatelessWidget {
  final Note note;

  ExtendedSection({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Center(
              child: Text(
                note.title,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          ExtendedInfoTab(
            fieldTitle: "Body:",
            fieldInfo: note.body,
          ),
           Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  ExtendedInfoTab(
      {Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Text(
                  fieldTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                fieldInfo,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
