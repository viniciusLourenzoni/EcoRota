import '../database/db_helper.dart';
import '../models/abastecimento_model.dart';

class AbastecimentoService {
  final dbHelper = DBHelper();

  Future<void> inserir(AbastecimentoModel abastecimento) async {
    final db = await dbHelper.db;
    await db.insert('abastecimentos', abastecimento.toMap());
  }

  Future<List<AbastecimentoModel>> listarTodos() async {
    final db = await dbHelper.db;
    final List<Map<String, dynamic>> maps = await db.query('abastecimentos');
    return maps.map((e) => AbastecimentoModel.fromMap(e)).toList();
  }

  Future<void> deletar(int id) async {
    final db = await dbHelper.db;
    await db.delete('abastecimentos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> limparTudo() async {
    final db = await dbHelper.db;
    await db.delete('abastecimentos');
  }
}
