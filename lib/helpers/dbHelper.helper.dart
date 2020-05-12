import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    //get a path/folder for a location within the device where a database can be created or currently exists
    final dbPath = await sql.getDatabasesPath();
    //specify the path and also the name of the db to be created
    //once the database is open/created, onCreate gives us access to a db object
    //note that onCreate will only happen if there is no existing places.db database
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: (db, version){
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
    //we can then insert stuff into the db
    //the conflict algo ensures if the data we are trying to insert already exists, it replaces it for us
    await sqlDb.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}

