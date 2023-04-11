import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modals/quotes.dart';

class PreviousQuotesDBHelper {
  PreviousQuotesDBHelper._();

  static final PreviousQuotesDBHelper previousQuotesDBHelper = PreviousQuotesDBHelper._();

  String tableName = "preQuote";

  String colName = "name";

  Database? db;

  Future<Database> initDatabase() async {
    var db = await openDatabase("myDb.db");

    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, "myDB.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int vision) async {
        await db.execute("CREATE TABLE IF NOT EXISTS $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT);");
      },
    );
    return db;
  }

  Future<void> insertData({int? id, required List<Quotes> quoteList}) async {
    db = await initDatabase();

    quoteList.forEach((element) async {
      String query = "INSERT INTO $tableName($colName) VALUES ('$element');";

      await db!.rawInsert(query);
    });
  }

  Future<List<Quotes>> fetchAllData() async {
    db = await initDatabase();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Quotes> quoteData = res.map((e) => Quotes.fromMap(data: e)).toList();

    return quoteData;
  }

  Future<int> deleteAllData() async {
    db = await initDatabase();

    String query = "DELETE FROM $tableName";

    return await db!.rawDelete(query);
  }
}
