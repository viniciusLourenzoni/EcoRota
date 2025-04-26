import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaAbastecimentos extends StatelessWidget {
  const ListaAbastecimentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final abastecimentos = [
      {
        'data': DateTime.now().subtract(const Duration(days: 2)),
        'litros': 45.5,
        'preco': 5.69,
        'total': 258.90,
        'posto': 'Posto Shell',
      },
      {
        'data': DateTime.now().subtract(const Duration(days: 8)),
        'litros': 42.0,
        'preco': 5.75,
        'total': 241.50,
        'posto': 'Posto BR',
      },
      {
        'data': DateTime.now().subtract(const Duration(days: 15)),
        'litros': 40.0,
        'preco': 5.65,
        'total': 226.00,
        'posto': 'Posto Ipiranga',
      },
    ];

    return ListView.builder(
      itemCount: abastecimentos.length,
      itemBuilder: (context, index) {
        final e = abastecimentos[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(
              DateFormat('dd/MM/yyyy').format(e['data'] as DateTime),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(e['posto'] as String),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$ ${(e['total'] as double).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${e['litros']} L  a  R\$ ${e['preco']}/L',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
