import 'package:sqflite/sqflite.dart';
import 'package:today_app/models/models.dart';
import 'package:today_app/models/notes.dart';

class DatabaseProvider {
  Database database;

  DatabaseProvider(this.database);

  Future<void> insertNote(Note note) async {
    final db =  database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteNote(Note note) async {
    final db =  database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // await insertNote(event.note);

  Future<Notes> notes() async {
    final db = await database;
     Notes notes=Notes();

    final List<Map<String, dynamic>> maps = await db.query('notes');

    List<Note> notesList= List.generate(maps.length, (i) {
      return Note(
        maps[i]['title'],
        maps[i]['subtitle'],
        id: maps[i]['id'],
      );
    });
    
    notes.setAllNotes(notesList);
    return notes;
  }
// print(await notes());

}
