import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/fuel_entry_form.dart';
import '../widgets/stats_card.dart';
import '../widgets/location_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
    }
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
              const StatsCard(),
              const SizedBox(height: 20),
              const FuelEntryForm(),
              const SizedBox(height: 20),
              if (_currentPosition != null)
                LocationMap(position: _currentPosition!),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const FuelEntryForm(),
          );
        },
        label: const Text('Adicionar Abastecimento'),
        icon: const Icon(Icons.local_gas_station),
      ),
    );
  }
}