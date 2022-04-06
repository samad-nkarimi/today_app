import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/models.dart';

class DatabaseProvider {
  static late Database database;

  Future<Notes> init() async {
    final databasePath = join(await getDatabasesPath(), 'notes_database.db');
    // await deleteDatabase(databasePath);
    database = await openDatabase(
      databasePath,
      onCreate: (db, version) async {
        print("history");
        await db.execute("""CREATE TABLE history
          (id TEXT PRIMARY KEY,
           repeat INTEGER,
           title TEXT,
           subtitle TEXT,
           color INTEGER
           )""");
        print("notes");
        await db.execute("""CREATE TABLE notes
          (id TEXT PRIMARY KEY,
           count INTEGER,
           repeat INTEGER,
           title TEXT,
           subtitle TEXT ,
           color INTEGER,
           hour INTEGER ,
           day INTEGER ,
           dayname TEXT ,
           month INTEGER ,
           year INTEGER ,
           istoday INTEGER ,
           isdone INTEGER
           )""");
      },
      version: 1,
    );
    // DatabaseProvider databaseProvider = DatabaseProvider(database);
    Notes notes;
    try {
      notes = await fetchNotes();
    } catch (e) {
      notes = Notes();
    }

    /*
    here we must try pick today notes due to the dates
    */
    print("notes: $notes");
    for (int i = 0; i < notes.notesList.length; i++) {
      Note note = notes.notesList[i];
      if (!note.isTodayNote) continue;
      int result =
          DateTime(1401, 0, 16).compareTo(DateTime(note.year, note.month, 16));
      print("result: $result");
      if (result == 0) {
        //this note is belong to today
        note.convertToTodayNote();
        await database.insert(
          'notes',
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else if (result == 1) {
        // print(note.props);
        await deleteNote(note);
      }
    }
    //after changes
    try {
      notes = await fetchNotes();
    } catch (e) {
      notes = Notes();
    }

    return notes;
  }

  // const DatabaseProvider(this.database);

  Future<void> insertNote(Note note) async {
    await database.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    int index = (await historyNotes())
        .notesList
        .indexWhere((e) => e.title == note.title);
    if (index == -1) {
      //we will have a new note in history
      await database.insert(
        'history',
        note.toMapForHistory(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      //the note is already in history
      final hnote = (await historyNotes()).notesList[index];
      hnote.subTitle =
          note.subTitle.isNotEmpty ? note.subTitle : hnote.subTitle;
      hnote.labelColor = note.labelColor;
      hnote.repeat++;
      await database.insert(
        'history',
        hnote.toMapForHistory(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
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

  static Future<Notes> fetchNotes() async {
    final db = database;
    Notes notes = Notes();

    final List<Map<String, dynamic>> maps = await db.query('notes');
    print("query: $maps");
    try {
      List<Note> notesList = List.generate(maps.length, (i) {
        final note = Note(
          maps[i]['title'],
          maps[i]['subtitle'],
          id: maps[i]['id'],
          labelColor: maps[i]['color'],
          isTodayNote: maps[i]["istoday"] == 1 ? true : false,
          isDone: maps[i]["isdone"] == 1 ? true : false,
          hour: maps[i]['hour'],
          day: maps[i]['day'],
          dayName: maps[i]['dayname'],
          month: maps[i]['month'],
          year: maps[i]['year'],
        );

        return note;
      });
      // print("notes: $notesList");
      notes.setAllNotes(notesList);
    } catch (e) {
      print(e);
    }
    // print("istoday: ${maps[0]["istoday"]}");
    // print("istoday: ${maps[1]["istoday"]}");
    // print("istoday: ${maps[2]["istoday"]}");
    // print("istoday: ${maps[3]["istoday"]}");
    return notes;
  }

  // and will sort notes
  static Future<Notes> historyNotes() async {
    final db = database;
    Notes notes = Notes();

    final List<Map<String, dynamic>> maps = await db.query('history');
    print("maps$maps");
    List<Note> notesList = List.generate(maps.length, (i) {
      final note = Note(
        maps[i]['title'],
        maps[i]['subtitle'],
        id: maps[i]['id'],
        labelColor: maps[i]['color'] ?? 0,
        repeat: maps[i]['repeat'],
      );

      return note;
    });
    notesList.sort((a, b) => b.repeat.compareTo(a.repeat));
    notes.setAllNotes(notesList);
    return notes;
  }
}
