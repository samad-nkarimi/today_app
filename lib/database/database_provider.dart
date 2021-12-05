import 'package:sqflite/sqflite.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';

class DatabaseProvider {
  Database database;

  DatabaseProvider(this.database);

  Future<void> insertNote(Note note) async {
    final db = database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteNote(Note note) async {
    final db = database;
    int count = await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.getId],
    );

    // print("count: ${note.getId}");

  }

  // await insertNote(event.note);

  Future<Notes> notes() async {
    final db = database;
    Notes notes = Notes();

    final List<Map<String, dynamic>> maps = await db.query('notes');
    print("query: $maps");

    List<Note> notesList = List.generate(maps.length, (i) {
      return Note(
        maps[i]['title'],
        maps[i]['subtitle'],
        id: maps[i]['id'],
        isTodayNote: maps[i]["istoday"] == 1 ? true : false,
      );
    });
    // print("notes: $notesList");
    // print("istoday: ${maps[0]["istoday"]}");
    // print("istoday: ${maps[1]["istoday"]}");
    // print("istoday: ${maps[2]["istoday"]}");
    // print("istoday: ${maps[3]["istoday"]}");
    notes.setAllNotes(notesList);
    return notes;
  }
// print(await notes());

}
