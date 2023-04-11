import 'dart:developer' as log_print;
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modals/quotes.dart';

class QuoteDatabaseHelper {
  QuoteDatabaseHelper._();

  static final QuoteDatabaseHelper quoteDatabaseHelper = QuoteDatabaseHelper._();

  Random random = Random();

  String tableName = "quote";

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

  Future<void> insertData({int? id,required List<Map<String, dynamic>> emotionList}) async {
    db = await initDatabase();

    List<String> angry = emotionList[0]["quotes"];
    List<String> fear = emotionList[1]["quotes"];
    List<String> pain = emotionList[2]["quotes"];
    List<String> confusion = emotionList[3]["quotes"];
    List<String> boredom = emotionList[4]["quotes"];
    List<String> sadness = emotionList[5]["quotes"];
    List<String> surprise = emotionList[6]["quotes"];
    List<String> horror = emotionList[7]["quotes"];

    angry.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    fear.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    pain.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    confusion.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    boredom.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    sadness.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    surprise.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });
    horror.forEach((element) async {
      String query = (element.contains("'")) ? "INSERT INTO $tableName($colName) VALUES ('When you have a dream, you have got to grab it and never let go');" : "INSERT INTO $tableName($colName) VALUES ('$element');";
      await db!.rawInsert(query);
    });

  }

  Future<List<Quotes>> fetchAllData({required String mood}) async {
    db = await initDatabase();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Quotes> quoteData = res.map((e) => Quotes.fromDB(data: e)).toList();

    List<int> randomNumbers = [];
    List<Quotes> returnDataList = [];

    for(int i = 0; i<= 20; i++)
      {
        randomNumbers.add(random.nextInt(17));
      }

    if(mood == "Angry")
      {
        final angry = List.generate(1, (index) => quoteData.map((e) => e).toList());

        log_print.log("$angry",name: "Angry List");
        final angryQuoteList = [];
        for(int i = 0; i<= 24; i++)
          {
            angryQuoteList.add(angry[0][i]);
          }

        for(int i = 0; i<= 15; i++)
        {
          returnDataList.add(angryQuoteList[randomNumbers[i]]);
        }
        log_print.log(returnDataList.toString(),name: "return Angry List");
        return returnDataList;
      }
    else if(mood == "Fear") {
      final fear = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final fearQuoteList = [];
      for(int i = 25; i<= 43; i++)
      {
        fearQuoteList.add(fear[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(fearQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }
    else if(mood == "Pain") {
      final pain = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final painQuoteList = [];
      for(int i = 44; i<= 71; i++)
      {
        painQuoteList.add(pain[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(painQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }
    else if(mood == "Confusion") {
      final confusion = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final confusionQuoteList = [];
      for(int i = 72; i<= 99; i++)
      {
        confusionQuoteList.add(confusion[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(confusionQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }
    else if(mood == "Boredom") {
      final boredom = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final boredomQuoteList = [];
      for(int i = 100; i<= 123; i++)
      {
        boredomQuoteList.add(boredom[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(boredomQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }
    else if(mood == "Sadness") {
      final sadness = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final sadnessQuoteList = [];
      for(int i = 124; i<= 147; i++)
      {
        sadnessQuoteList.add(sadness[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(sadnessQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }
    else if(mood == "Surprise") {
      final surprise = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final surpriseQuoteList = [];
      for(int i = 148; i<= 169; i++)
      {
        surpriseQuoteList.add(surprise[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(surpriseQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }
    else if(mood == "Horror") {
      final horror = List.generate(1, (index) => quoteData.map((e) => e).toList());

      final horrorQuoteList = [];
      for(int i = 170; i<= 190; i++)
      {
        horrorQuoteList.add(horror[0][i]);

      }
      for(int i = 0; i<= 15; i++)
      {
        returnDataList.add(horrorQuoteList[randomNumbers[i]]);
      }
      return returnDataList;
    }

    return quoteData;
  }


  Future<int> deleteAllData() async {
    db = await initDatabase();

    String query = "DELETE FROM $tableName";

    return await db!.rawDelete(query);
  }
}
