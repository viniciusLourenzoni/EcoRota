import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'refueling_screen.dart';
import 'stations_screen.dart';
import '../widgets/fuel_entry_form.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EcoRota - Controle de Abastecimentos'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
              Tab(icon: Icon(Icons.local_gas_station), text: 'Abastecimentos'),
              Tab(icon: Icon(Icons.map), text: 'Postos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DashboardScreen(),
            RefuelingScreen(),
            StationsScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const FuelEntryForm(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}