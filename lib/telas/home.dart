import 'package:eco_rota/componentes/cartao_estatisticas.dart';
import 'package:eco_rota/componentes/formulario_abastecimento.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoRota - Controle de Abastecimentos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CartaoEstatisticas(),
              const SizedBox(height: 20),
              const FormularioAbastecimento(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const FormularioAbastecimento(),
          );
        },
        label: const Text('Adicionar Abastecimento'),
        icon: const Icon(Icons.local_gas_station),
      ),
    );
  }
}