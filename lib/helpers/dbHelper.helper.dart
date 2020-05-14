import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    //get a path/folder for a location within the device where a database can be created or currently exists
    final dbPath = await sql.getDatabasesPath();
    //specify the path and also the name of the db to be created
    //once the database is open/created, onCreate gives us access to a db object
    //note that onCreate will only happen if there is no existing places.db database
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    //we can then insert stuff into the db
    //the conflict algo ensures if the data we are trying to insert already exists, it replaces it for us
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
