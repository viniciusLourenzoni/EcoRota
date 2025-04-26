
import 'package:eco_rota/componentes/formulario_abastecimento.dart';
import 'package:eco_rota/telas/postos.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'abastecimento.dart';

class Abas extends StatelessWidget {
  const Abas({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EcoRota – Controle de Abastecimentos'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Painel'),
              Tab(icon: Icon(Icons.local_gas_station), text: 'Abastecimentos'),
              Tab(icon: Icon(Icons.map), text: 'Postos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Dashboard(),
            Abastecimento(),
            Postos(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const FormularioAbastecimento(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}