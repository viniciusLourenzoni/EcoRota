import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbyStations extends StatefulWidget {
  final Position position;

  const NearbyStations({
    super.key,
    required this.position,
  });

  @override
  State<NearbyStations> createState() => _NearbyStationsState();
}

class _NearbyStationsState extends State<NearbyStations> {
  List<Map<String, dynamic>> _stations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNearbyStations();
  }

  Future<void> _fetchNearbyStations() async {
    try {
      // TODO: Implementar chamada real à API da ANP
      final response = await http.get(
        Uri.parse('https://api.precos.anp.gov.br/v1/postos/municipio/3550308'),
        headers: {'Authorization': 'Bearer seu_token_aqui'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Processar dados da API
        setState(() {
          _stations = [
            {
              'name': 'Posto Shell',
              'price': 5.69,
              'distance': 0.5,
              'lastUpdate': DateTime.now().subtract(const Duration(hours: 2)),
            },
            {
              'name': 'Posto BR',
              'price': 5.75,
              'distance': 0.8,
              'lastUpdate': DateTime.now().subtract(const Duration(hours: 1)),
            },
            {
              'name': 'Posto Ipiranga',
              'price': 5.65,
              'distance': 1.2,
              'lastUpdate': DateTime.now().subtract(const Duration(hours: 3)),
            },
          ];
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Erro ao buscar postos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _stations.length,
      itemBuilder: (context, index) {
        final station = _stations[index];
        return ListTile(
          title: Text(station['name']),
          subtitle: Text('${station['distance']} km'),
          trailing: Text(
            'R\$ ${station['price'].toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onTap: () {
            // Implementar ação ao selecionar posto
          },
        );
      },
    );
  }
}