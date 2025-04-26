import 'package:flutter/material.dart';

class CartaoEstatisticas extends StatelessWidget {
  const CartaoEstatisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Estatísticas de Consumo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _LinhaEstatisticas(),
          ],
        ),
      ),
    );
  }
}

class _LinhaEstatisticas extends StatelessWidget {
  const _LinhaEstatisticas({super.key});

  @override
  Widget build(BuildContext context) {
    final corPrimaria = Theme.of(context).colorScheme.primary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _ItemEstatistica(
          label: 'Consumo Médio',
          valor: '8,5 L/100km',
          icone: Icons.speed,
        ),
        _ItemEstatistica(
          label: 'Distância Total',
          valor: '1.234 km',
          icone: Icons.route,
        ),
        _ItemEstatistica(
          label: 'Último Preço',
          valor: 'R\$ 5,75/L',
          icone: Icons.local_gas_station,
        ),
      ],
    );
  }
}

class _ItemEstatistica extends StatelessWidget {
  final String label;
  final String valor;
  final IconData icone;

  const _ItemEstatistica({
    super.key,
    required this.label,
    required this.valor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    final corPrimaria = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        Icon(icone, color: corPrimaria, size: 28),
        const SizedBox(height: 8),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
