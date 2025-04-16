import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:group_4_final_project_library_app/models/db_result.dart';


class DBHelper {
  static final DBHelper dblibrary = DBHelper._init();
  static Database? _database;


  DBHelper._init();
  
  Future<Database> get libraryDatabase async {
    if (_database != null) return _database!;
    _database = await _getDB();
    return _database!;
  }

  Future<Database> _getDB() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Final.db');

    return await openDatabase(
        path,
      version: 1,
        onCreate: _createDatabase,
    );
  }


// create data base class 3 tables student table book table linking table include the witrhdrawn date an return date into linking table
Future<void> _createDatabase(Database db, int version) async{
    await db.execute('''
    CREATE TABLE student (
    studentId INTERGER PRIMARY KEY AUTOINCREMENT,
    studentNumber TEXT,
    fullName TEXT,
    email TEXT,
    password TEXT,
    year TEXT,
    program TEXT,
      )
      ''');

    await db.execute('''
    CREATE TABLE books (
    bookID INTERGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    genre TEXT,
    description TEXT,
    bookCover TEXT,
    author TEXT,
    withdrawn BOOL DEFAULT false   
    )
    ''');

    await db.execute(
      '''
      CREATE TABLE withdrawn (
      withdrawId INTERGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER FOREIGN KEY,
      bookId INTEGER FOREIGN KEY
      withdrawDate DATETIME,
      dueDate DATETIME
      )
   ''' );
}

// read all books function


// insert into student table


//seed data function


//insert into linking table





// toggle withdrawn


}

