import 'package:bibit_test/Model/alarm.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class AlarmDatabase{
  static final AlarmDatabase instance = AlarmDatabase._init();
  static Database _database;
  AlarmDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await _initDB('alarm.db');
    return _database;
  }

  Future<Database> _initDB(String filepath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute(
      '''
        CREATE TABLE $tableAlarm(
          ${AlarmFields.id} $idType,
          ${AlarmFields.hour} $textType,
          ${AlarmFields.minute} $textType
        )
      '''
    );
  }

  Future<Alarm> create(Alarm product) async{
    final db = await instance.database;
    final id = await db.insert(tableAlarm, product.toJson());

    return product.copy(id: id);
  }

  Future<Alarm> readProduct(int id) async{
    final db = await instance.database;

    final maps = await db.query(
      tableAlarm,
      columns: AlarmFields.values,
      where: '${AlarmFields.id} = ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty){
      return Alarm.fromJson(maps.first);
    }else{
      throw Exception('ID not found');
    }
  }

  Future<List<Alarm>> getAllAlarms() async{
    final db = await instance.database;

    final result = await db.query(tableAlarm);
    return result.map((e) => Alarm.fromJson(e)).toList();
  }

  Future<int> update(Alarm alarm)async{
    final db = await instance.database;
    return db.update(tableAlarm, alarm.toJson(), where: '${AlarmFields.id} = ?', whereArgs: [alarm.id]);
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableAlarm,
      where: '${AlarmFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
  
}