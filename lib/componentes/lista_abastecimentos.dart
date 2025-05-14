import 'package:flutter/material.dart';
import '../models/abastecimento_model.dart';
import '../services/abastecimento_service.dart';

class ListaAbastecimentos extends StatefulWidget {
  const ListaAbastecimentos({super.key});

  @override
  State<ListaAbastecimentos> createState() => _ListaAbastecimentosState();
}

class _ListaAbastecimentosState extends State<ListaAbastecimentos> {
  List<AbastecimentoModel> _abastecimentos = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final dados = await AbastecimentoService().listarTodos();
    setState(() => _abastecimentos = dados);
  }

  @override
  Widget build(BuildContext context) {
    if (_abastecimentos.isEmpty) {
      return const Center(child: Text('Nenhum abastecimento registrado'));
    }

    return ListView.builder(
      itemCount: _abastecimentos.length,
      itemBuilder: (context, index) {
        final e = _abastecimentos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(e.data),
            subtitle: Text(e.posto),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$ ${(e.litros * e.preco).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${e.litros} L a R\$ ${e.preco.toStringAsFixed(2)}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
