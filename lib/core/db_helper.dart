import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:group_4_final_project_library_app/models/db_result.dart';
import 'package:group_4_final_project_library_app/models/Student.dart';

import '../models/Book.dart';

class DBHelper {
  static final DBHelper dblibrary = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get libraryDatabase async {
    if (_database != null) return _database!;
    _database = await _getDB();
    return _database!;
  }

  Future<Database> _getDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'Final.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

// create data base class 3 tables student table book table linking table include the witrhdrawn date an return date into linking table
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE student (
      studentId INTEGER PRIMARY KEY AUTOINCREMENT,
      studentNumber TEXT,
      fullName TEXT,
      email TEXT,
      password TEXT,
      year TEXT,
      program TEXT
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

    await db.execute('''
    CREATE TABLE withdrawn (
      withdrawId INTEGER PRIMARY KEY AUTOINCREMENT,
      studentId INTEGER,
      bookId INTEGER,
      withdrawDate DATETIME,
      dueDate DATETIME,
      FOREIGN KEY (studentId) REFERENCES student(studentId),
      FOREIGN KEY (bookId) REFERENCES books(bookID)
    )
  ''');
  }

// read all books function
  Future<List<Book>> getAllBooks() async {
    final db = await libraryDatabase;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return maps.map((map) => Book.fromMap(map)).toList();
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
  Future<DBResult> addBooks() async {
    final db = await libraryDatabase;

    // Check if the books table already has records
    final countResult = await db.rawQuery('SELECT COUNT(*) as count FROM books');
    final count = Sqflite.firstIntValue(countResult);

    if (count != null && count > 0) {
      return DBResult(
        isSuccess: false,
        message: 'Books already exist in the database. Skipping seeding.',
        libraryList: [],
      );
    }

    // Seed book data
    final List<Book> seedBooks = [
      Book(
        "The Catcher in the Rye",
        "J.D. Salinger",
        "Young Adult",
        "It's Christmas time and Holden Caulfield has just been expelled from yet another school... Fleeing the crooks at Pencey Prep, he pinballs around New York City seeking solace in fleeting encounters—shooting the bull with strangers in dive hotels, wandering alone round Central Park, getting beaten up by pimps and cut down by erstwhile girlfriends. The city is beautiful and terrible, in all its neon loneliness and seedy glamour, its mingled sense of possibility and emptiness. Holden passes through it like a ghost, thinking always of his kid sister Phoebe, the only person who really understands him, and his determination to escape the phonies and find a life of true meaning",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1398034300i/5107.jpg",
      ),
      Book(
        "1984",
        "George Orwell",
        "Dystopian",
        "Winston Smith toes the Party line, rewriting history to satisfy the demands of the Ministry of Truth. But he secretly dreams of rebellion and freedom. In a world of perpetual war, omnipresent government surveillance, and public mind control, 1984 is a chilling depiction of a totalitarian regime taken to its ultimate extreme.",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1532714506i/40961427.jpg",
      ),
      Book(
        "To Kill a Mockingbird",
        "Harper Lee",
        "Classic",
        "Set in the Deep South during the 1930s, this Pulitzer Prize-winning novel sees young Scout Finch come of age as her father, lawyer Atticus Finch, defends a black man accused of assaulting a white woman. The story explores themes of racial injustice, moral growth, and compassion.",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1553383690i/2657.jpg",
      ),
      Book(
        "Dune",
        "Frank Herbert",
        "Science Fiction",
        "Set on the desert planet Arrakis, Dune tells the story of Paul Atreides, whose noble family accepts control of the planet. As betrayal, prophecy, and power collide, Paul must navigate a dangerous political and ecological landscape to fulfill his destiny.",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1555447414i/44767458.jpg",
      ),
      Book(
        "Pride and Prejudice",
        "Jane Austen",
        "Romance",
        "Elizabeth Bennet navigates the complexities of love, class, and social expectations in 19th-century England. As she spars with the proud Mr. Darcy, misunderstandings and revelations lead to one of literature's most beloved love stories.",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1320399351i/1885.jpg",
      ),
      Book(
        "The Hobbit",
        "J.R.R. Tolkien",
        "Fantasy",
        "Bilbo Baggins is swept into an epic quest by the wizard Gandalf and a group of dwarves. As they journey to reclaim a stolen treasure from the dragon Smaug, Bilbo discovers courage and cunning he never knew he had.",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1546071216i/5907.jpg",
      ),
      Book(
        "The Great Gatsby",
        "F. Scott Fitzgerald",
        "Classic",
        "Nick Carraway is drawn into the lavish and mysterious world of Jay Gatsby, a wealthy man known for his extravagant parties and secret longing for Daisy Buchanan. Set in the Roaring Twenties, it's a story of love, illusion, and the American Dream.",
        "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1490528560i/4671.jpg",
      ),
    ];

    try {
      for (Book book in seedBooks) {
        await db.insert('books', book.toMap());
      }

      return DBResult(
        isSuccess: true,
        message: 'Seed books successfully added.',
        libraryList: [],
      );
    } catch (e) {
      return DBResult(
        isSuccess: false,
        message: 'Error inserting books: $e',
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
  Future<Student?> getStudentForLogin(
      String studentNumber, String password) async {
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
