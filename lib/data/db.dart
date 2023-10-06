import 'package:arknights_gerenciador/data/event_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'event_database.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(EventDao.tableSql);
    },
    version: 1,
  );
}