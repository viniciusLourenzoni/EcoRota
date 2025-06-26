import 'package:flutter/material.dart';
import '../services/combustivel_service.dart';

class Postos extends StatefulWidget {
  const Postos({super.key});

  @override
  State<Postos> createState() => _PostosState();
}

class _PostosState extends State<Postos> {
  final List<String> _estados = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

  String? _estadoSelecionado;
  Map<String, String>? _dados;
  bool _carregando = false;

  void _buscar() async {
    if (_estadoSelecionado == null) return;

    setState(() => _carregando = true);

    try {
      final resultado = await PrecoService.buscarPorEstado(_estadoSelecionado!);
      setState(() {
        _dados = resultado;
        _carregando = false;
      });
    } catch (_) {
      setState(() => _carregando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao buscar os dados.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preços por Estado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Selecione o estado'),
              value: _estadoSelecionado,
              items: _estados.map((uf) {
                return DropdownMenuItem(value: uf, child: Text(uf));
              }).toList(),
              onChanged: (valor) {
                setState(() => _estadoSelecionado = valor);
                _buscar();
              },
            ),
            const SizedBox(height: 24),
            if (_carregando)
              const Center(child: CircularProgressIndicator()),
            if (_dados != null && !_carregando)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gasolina: R\$ ${_dados!['gasolina']}'),
                  Text('Diesel:   R\$ ${_dados!['diesel']}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
