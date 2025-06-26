import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostosProximos extends StatefulWidget {
  final Position posicao;

  const PostosProximos({super.key, required this.posicao});

  @override
  State<PostosProximos> createState() => _PostosProximosState();
}

class _PostosProximosState extends State<PostosProximos> {
  List<Map<String, dynamic>> _postos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarPostosPrecoParana();
  }

  double calcularDistancia(
      double latPosto, double lonPosto, Position atual) {
    return Geolocator.distanceBetween(
        atual.latitude, atual.longitude, latPosto, lonPosto) /
        1000;
  }

  Future<void> _buscarPostosPrecoParana() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.mpd.pr.gov.br/api/preco-parana/postos')); // pode filtrar depois se quiser

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        final List<Map<String, dynamic>> postos = data.map((item) {
          final distancia = calcularDistancia(
            double.parse(item['latitude'].toString()),
            double.parse(item['longitude'].toString()),
            widget.posicao,
          );

          return {
            'nome': item['razaoSocial'],
            'preco': item['preco'],
            'distancia': distancia,
            'ultimaAtualizacao': item['dataColeta'],
          };
        }).toList();

        postos.sort((a, b) => a['distancia'].compareTo(b['distancia']));

        setState(() {
          _postos = postos.take(10).toList(); // limita aos 10 mais próximos
          _carregando = false;
        });
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao buscar postos: $e');
      setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) return const Center(child: CircularProgressIndicator());

    return ListView.builder(
      itemCount: _postos.length,
      itemBuilder: (context, index) {
        final posto = _postos[index];
        return ListTile(
          title: Text(posto['nome']),
          subtitle: Text('${posto['distancia'].toStringAsFixed(2)} km'),
          trailing: Text(
            'R\$ ${posto['preco'].toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
