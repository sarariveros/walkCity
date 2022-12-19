import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:walkcity/src/models/site_model.dart';

class DBSite {
  static const _dbName = 'Site';
  static const _dbVersion = 1;
  static const table = 'sites';
  static const columnTitulo = 'titulo';
  static const columnDescripcion = 'descripcion';
  static const columnCategoria = 'categoria';
  static const columnLon = 'lon';
  static const columnLat = 'lat';
  static const columnId = 'id';
  static const columnImage = 'image';
  // static const comentario = List<Comentario>;
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
  Future<int> newFavorite(Site site) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'id': site.id,
      'titulo': site.nombre,
      'categoria': site.categoria,
      'lon': site.lon,
      'lat': site.lat,
      'image': site.imagen
    });
  }

  /////Listar productos
  Future<List<Map<String, dynamic>>> queryAllFavorites() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  /////borrar un producto////
  Future<int> deleteFavorite(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId= ?', whereArgs: [id]);
  }

  ///borrar todos los productos
  Future deleteAllFavorites() async {
    Database? db = await instance.database;
    db!.delete(table);
  }

  ////actualizar
  Future<int?> updateFavorite(Site producto) async {
    Database? db = await instance.database;
    int id = producto.toMapFavDB()['id'];
    return await db!.update(table, producto.toMapFavDB(),
        where: '$columnId=?', whereArgs: [id]);
  }
}
