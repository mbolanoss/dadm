import 'package:path/path.dart';
import 'package:reto_8/models/company.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  Database? _db;
  final tableName = 'companies';

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initialize();
    return _db!;
  }

  Future<String> get fullPath async {
    const name = 'companies.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    Database database = await openDatabase(path,
        version: 1, onCreate: createDB, singleInstance: true);

    return database;
  }

  Future<void> createDB(Database database, int version) async {
    await createTable(database);
  }

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    url TEXT,
    phoneNumber INTEGER,
    email TEXT,
    services TEXT,
    type TEXT
    );""");
  }

  Future<int> insertCompany(Company company) async {
    return await _db!.insert(
      tableName,
      company.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteCompany(Company company) async {
    await _db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [company.id],
    );
  }

  Future<void> updateCompany(Company company) async {
    await _db!.update(
      tableName,
      company.toMap(),
      where: 'id = ?',
      whereArgs: [company.id],
    );
  }

  Future<List<Company>> getAllCompanies() async {
    final rawList = await _db!.query(tableName);

    return List.generate(
      rawList.length,
      (index) => Company.fromMap(
        rawList[index],
      ),
    );
  }

  Future<List<Company>> searchCompanies(String name, String type) async {
    String whereQuery = '';
    List<String> whereArgs = [];

    if (name != '' && type != '') {
      whereQuery = 'name = ? AND type = ?';
      whereArgs = [name, type];
    } else if (name != '' && type == '') {
      whereQuery = 'name = ?';
      whereArgs = [name];
    } else if (name == '' && type != '') {
      whereQuery = 'type = ?';
      whereArgs = [type];
    }

    final rawList = await _db!.query(
      tableName,
      where: whereQuery,
      whereArgs: whereArgs,
    );

    return List.generate(
      rawList.length,
      (index) => Company.fromMap(
        rawList[index],
      ),
    );
  }
}
