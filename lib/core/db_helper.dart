import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:group_4_final_project_library_app/models/db_result.dart';
import 'package:group_4_final_project_library_app/models/Student.dart';


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
    studentId INTEGER PRIMARY KEY AUTOINCREMENT,
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
    bookID INTEGER PRIMARY KEY AUTOINCREMENT,
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
      withdrawId INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER,
      bookId INTEGER,
      withdrawDate DATETIME,
      dueDate DATETIME
      FOREIGN KEY (studentId) REFERENCES student(studentId),
      FOREIGN KEY (bookId) REFERENCES books(bookID)
      )
   ''' );
}

// read all books function
  Future<List<Map<String, dynamic>>> getAllBooks() async {
    final db = await libraryDatabase;

    return await db.query('books');
  }


// insert into student table
  Future<DBResult> addStudent(Map<String, dynamic> studentDetails) async {
    final db = await libraryDatabase;

    try {
      await db.insert('student', studentDetails);
      String studentNumber = studentDetails['studentNumber'];

      return DBResult(
        isSuccess: true,
        message: 'account created with student number: $studentNumber',
        libraryList: [],
      );
    } catch (e) {
      return DBResult(
        isSuccess: false,
        message: 'Error inserting student: $e',
        libraryList: [],
      );
    }
  }


//seed data function a create book function being clled 7-10 to have books in database


//insert into withdrawn table
  Future<DBResult> addIntoWithdrawn(Map<String, dynamic> withdrawnDetails) async {
    final db = await libraryDatabase;

    try {
      await db.insert('withdrawn', withdrawnDetails);
      return DBResult(
        isSuccess: true,
        message: 'Book withdrawn',
        libraryList: [],
      );
    } catch (e) {
      return DBResult(
        isSuccess: false,
        message: 'could not withdraw book ',
        libraryList: [],
      );
    }
  }


// delete from withdrawn table
  Future<DBResult> returnBook(int withdrawId) async {
    final db = await libraryDatabase;

    try {
      int result = await db.delete(
        'withdrawn',
        where: 'withdrawId = ?',
        whereArgs: [withdrawId],
      );

      if (result > 0) {
        return DBResult(
          isSuccess: true,
          message: 'Book has been returned ',
          libraryList: [],
        );
      } else {
        return DBResult(
          isSuccess: false,
          message: 'Could not return book',
          libraryList: [],
        );
      }
    } catch (e) {
      return DBResult(
        isSuccess: false,
        message: 'Error deleting record: $e',
        libraryList: [],
      );
    }
  }

// get student by student number  and password
  Future<Student?> getStudentForLogin(String studentNumber, String password) async {
    final db = await libraryDatabase;


    final List<Map<String, dynamic>> result = await db.query(
      'student',
      where: 'studentNumber = ? AND password = ?',
      whereArgs: [studentNumber, password],
    );


    if (result.isNotEmpty) {

      final studentInfo = result.first;
      return Student()
        ..id = studentInfo['studentId']
        ..studentNumber = studentInfo['studentNumber']
        ..name = studentInfo['fullName']
        ..email = studentInfo['email']
        ..password = studentInfo['password']
        ..year = studentInfo['year']
        ..program = studentInfo['program'];
    }

    return null;
  }



// update withdrawn this will change the bool in the books table


}

