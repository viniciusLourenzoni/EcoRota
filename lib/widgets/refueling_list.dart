import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RefuelingList extends StatelessWidget {
  const RefuelingList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados simulados
    final refuelings = [
      {
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'liters': 45.5,
        'price': 5.69,
        'total': 258.90,
        'station': 'Posto Shell',
      },
      {
        'date': DateTime.now().subtract(const Duration(days: 8)),
        'liters': 42.0,
        'price': 5.75,
        'total': 241.50,
        'station': 'Posto BR',
      },
      {
        'date': DateTime.now().subtract(const Duration(days: 15)),
        'liters': 40.0,
        'price': 5.65,
        'total': 226.00,
        'station': 'Posto Ipiranga',
      },
    ];

    return ListView.builder(
      itemCount: refuelings.length,
      itemBuilder: (context, index) {
        final refueling = refuelings[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(
              DateFormat('dd/MM/yyyy').format(refueling['date'] as DateTime),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(refueling['station'] as String),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'R\$ ${(refueling['total'] as double).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${refueling['liters']}L a R\$ ${refueling['price']}/L',
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