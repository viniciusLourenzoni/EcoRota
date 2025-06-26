import 'package:flutter/material.dart';
import '../services/abastecimento_service.dart';

class CartaoEstatisticas extends StatefulWidget {
  const CartaoEstatisticas({super.key});

  @override
  State<CartaoEstatisticas> createState() => _CartaoEstatisticasState();
}

class _CartaoEstatisticasState extends State<CartaoEstatisticas> {
  double consumoMedio = 0;
  int distanciaTotal = 0;
  double ultimoPreco = 0;

  @override
  void initState() {
    super.initState();
    _carregarEstatisticas();
  }

  Future<void> _carregarEstatisticas() async {
    final lista = await AbastecimentoService().listarTodos();
    if (lista.length < 2) return;

    lista.sort((a, b) => a.odometro.compareTo(b.odometro));
    final kmInicial = lista.first.odometro;
    final kmFinal = lista.last.odometro;
    final litrosTotais = lista.fold<double>(0, (soma, e) => soma + e.litros);

    setState(() {
      distanciaTotal = kmFinal - kmInicial;
      consumoMedio = distanciaTotal > 0 ? (litrosTotais / distanciaTotal) * 100 : 0;
      ultimoPreco = lista.last.preco;
    });
  }

  @override
  Widget build(BuildContext context) {
    final corPrimaria = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estatísticas de Consumo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ItemEstatistica(
                  label: 'Consumo Médio',
                  valor: '${consumoMedio.toStringAsFixed(1)} L/100km',
                  icone: Icons.speed,
                  cor: corPrimaria,
                ),
                _ItemEstatistica(
                  label: 'Distância Total',
                  valor: '$distanciaTotal km',
                  icone: Icons.route,
                  cor: corPrimaria,
                ),
                _ItemEstatistica(
                  label: 'Último Preço',
                  valor: 'R\$ ${ultimoPreco.toStringAsFixed(2)}/L',
                  icone: Icons.local_gas_station,
                  cor: corPrimaria,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemEstatistica extends StatelessWidget {
  final String label;
  final String valor;
  final IconData icone;
  final Color cor;

  const _ItemEstatistica({
    super.key,
    required this.label,
    required this.valor,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icone, color: cor, size: 28),
        const SizedBox(height: 8),
        Text(
          valor,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
