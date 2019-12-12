import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly_note/bloc/global_bloc.dart';
import 'package:quickly_note/models/notes.dart';

import 'addnote.dart';
import 'notedetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quickly"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Provider<GlobalBloc>.value(
                child: NotesContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "add a post",
      ),
    );
  }
}

class NotesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Note>>(
      stream: _globalBloc.noteList$,
      builder: (context, snapshot) {
        // if (!snapshot.hasData) {
        //   return Container();
        // }
        if (snapshot.data.length == 0) {
          return Container(
            color: Colors.black87,
            child: Center(
              child: Text(
                "Press + to add a note quickly",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.black87,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 12),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return NoteCard(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black87,
        child: Container(
          decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
          child: ListTile(
            title: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder<Null>(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return AnimatedBuilder(
                          animation: animation,
                          builder: (BuildContext context, Widget child) {
                            return Opacity(
                              opacity: animation.value,
                              child: NoteDetails(note),
                            );
                          });
                    },
                    transitionDuration: Duration(milliseconds: 200),
                  ),
                );
              },
              title: Hero(
                tag: note.title,
                child: Text(
                    note.title,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                child: Text(
                  note.body,
                  style: TextStyle(fontSize: 12.0, color: Colors.white70),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
