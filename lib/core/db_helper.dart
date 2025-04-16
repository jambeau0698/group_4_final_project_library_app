import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:group_4_final_project_library_app/models/db_result.dart';


class DBHelper {
  static final DBHelper dblibrary = DBHelper._init();
  static Database? _database;


  DBHelper._init();
  
  Future<Database> get libraryDatabase async {
    if (_database !=) return _database;
    _database = await _getDB();
    return _database;
  }

  Future<Database> _getDB() async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '')
  }
}

