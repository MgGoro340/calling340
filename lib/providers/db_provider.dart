import 'dart:io';

import 'package:numerologia001/models/carta_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'numerologia001.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE cartaNumerologica ('
          ' id INTEGER PRIMARY KEY,'
          ' caminoVida TEXT,'
          ' nacimiento TEXT,'
          ' caminoAlma TEXT,'
          ' personalidad TEXT,'
          ' temperamento TEXT,'
          ' mision TEXT,'
          ' metaFinal TEXT,'
          ' compatibilidadPareja TEXT,'
          ' fechaNacimiento TEXT,'
          ' nombre TEXT,'
          ' sumatoriaVocal TEXT,'
          ' sumatoriaConsonante TEXT'
          ')');
    });
  }

  // CREAR Registros
  // nuevoCartaRaw(CartaModel nuevaCarta) async {
  //   final db = await database;

  //   final sqltext = "INSERT Into cartaNumerologica ( id, caminoVida, caminoAlma, " +
  //       "  personalidad, temperamento, mision,  " +
  //       "  metaFinal, compatibilidadPareja, fechaNacimiento, " +
  //       "  nombre, sumatoriaVocal, sumatoriaConsonante)  " +
  //       "VALUES ( ${nuevaCarta.id}, '${nuevaCarta.caminoVida}', '${nuevaCarta.caminoAlma}', " +
  //       "          '${nuevaCarta.personalidad}', '${nuevaCarta.temperamento}', '${nuevaCarta.mision}', " +
  //       "          '${nuevaCarta.metaFinal}', '${nuevaCarta.compatibilidadPareja}', '${nuevaCarta.fechaNacimiento}', " +
  //       "          '${nuevaCarta.nombre}', ${nuevaCarta.sumatoriaVocal}, ${nuevaCarta.sumatoriaConsonante} " +
  //       " )";
  //   print(" sql insert: $sqltext ");
  //   final res = await db.rawInsert(sqltext);
  //   return res;
  // }

  nuevaCarta(CartaModel nuevoCarta) async {
    final db = await database;
    int res = await db.insert('cartaNumerologica', nuevoCarta.toJson());
    return res;
  }

  // SELECT - Obtener información
  Future<CartaModel> getCartaId(int id) async {
    final db = await database;
    final res =
        await db.query('cartaNumerologica', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? CartaModel.fromJson(res.first) : null;
  }

  Future<List<CartaModel>> getTodosCartas() async {
    final db = await database;
    final res = await db.query('cartaNumerologica');

    List<CartaModel> list =
        res.isNotEmpty ? res.map((c) => CartaModel.fromJson(c)).toList() : [];
    return list;
  }

  // Actualizar Registros
  Future<int> updateCarta(CartaModel nuevoCarta) async {
    final db = await database;
    final res = await db.update('cartaNumerologica', nuevoCarta.toJson(),
        where: 'id = ?', whereArgs: [nuevoCarta.id]);
    return res;
  }

  // Eliminar registros
  Future<int> deleteCarta(int id) async {
    final db = await database;
    final res =
        await db.delete('cartaNumerologica', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM cartaNumerologica');
    return res;
  }
}
