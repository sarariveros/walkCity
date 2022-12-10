import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:walkcity/src/models/site_model.dart';

class DBSite {
  static const _dbName = 'Site';
  static const _dbVersion = 1;
  static const table = 'Sites';
  static const columnTitulo = 'titulo';
  static const columnDescripcion = 'descripcion';
  static const columnCategoria = 'categoria';
  static const columnLon = 'lon';
  static const columnLat = 'lat';
  static const columnId = 'id';
  static const columnImage = 'image';
  DBSite._privateConstructor();
  static final DBSite instance = DBSite._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $table(
  $columnId INTEGER PRIMARY KEY ,
  $columnTitulo TEXT NOT NULL,
  $columnCategoria TEXT NOT NULL,
  $columnDescripcion TEXT NOT NULL,
  $columnLon TEXT NOT NULL,
  $columnLat TEXT NOT NULL,
  $columnImage TEXT NOT NULL
  )''');
  }

  /////create product
  Future<int> newSite(Site site) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'id': site.id,
      'titulo': site.titulo,
      'categoria': site.categoria,
      'descripcion': site.descripcion,
      'lon': site.lon,
      'lat': site.lat,
      'image': site.image
    });
  }

  /////Listar productos
  Future<List<Map<String, dynamic>>> queryAllSites() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  /////borrar un producto////
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId= ?', whereArgs: [id]);
  }

  ///borrar todos los productos
  Future deleteAll() async {
    Database? db = await instance.database;
    db!.delete(table);
  }

  ////actualizar
  Future<int?> update(Site producto) async {
    Database? db = await instance.database;
    int id = producto.toMap()['id'];
    return await db!
        .update(table, producto.toMap(), where: '$columnId=?', whereArgs: [id]);
  }
}
