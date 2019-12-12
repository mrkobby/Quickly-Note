class Note {
  final String title;
  final String body;
  final List<dynamic> noteIDs;

  Note({this.noteIDs, this.title, this.body});

  String get getTitle => title;
  String get getBody => body;
  List<dynamic> get getNoteIDs => noteIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": this.noteIDs,
      "title": this.title,
      "body": this.body,
    };
  }

  factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(
      noteIDs: parsedJson['ids'],
      title: parsedJson['title'],
      body: parsedJson['body'],
    );
  }
}
