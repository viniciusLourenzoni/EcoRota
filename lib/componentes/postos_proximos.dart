import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostosProximos extends StatefulWidget {
  final Position posicao;

  const PostosProximos({
    super.key,
    required this.posicao,
  });

  @override
  State<PostosProximos> createState() => _PostosProximosState();
}

class _PostosProximosState extends State<PostosProximos> {
  List<Map<String, dynamic>> _postos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarPostosProximos();
  }

  Future<void> _buscarPostosProximos() async {
    try {
      // TODO: implementar chamada real à API da ANP
      final response = await http.get(
        Uri.parse('https://api.precos.anp.gov.br/v1/postos/municipio/3550308'),
        headers: {'Authorization': 'Bearer seu_token_aqui'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // processar dados da API real aqui, por enquanto simula:
        setState(() {
          _postos = [
            {
              'nome': 'Posto Shell',
              'preco': 5.69,
              'distancia': 0.5,
              'ultimaAtualizacao': DateTime.now().subtract(const Duration(hours: 2)),
            },
            {
              'nome': 'Posto BR',
              'preco': 5.75,
              'distancia': 0.8,
              'ultimaAtualizacao': DateTime.now().subtract(const Duration(hours: 1)),
            },
            {
              'nome': 'Posto Ipiranga',
              'preco': 5.65,
              'distancia': 1.2,
              'ultimaAtualizacao': DateTime.now().subtract(const Duration(hours: 3)),
            },
          ];
          _carregando = false;
        });
      } else {
        throw Exception('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao buscar postos: $e');
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _postos.length,
      itemBuilder: (context, index) {
        final posto = _postos[index];
        return ListTile(
          title: Text(posto['nome'] as String),
          subtitle: Text('${posto['distancia']} km'),
          trailing: Text(
            'R\$ ${(posto['preco'] as double).toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onTap: () {
            // ação ao selecionar posto
          },
        );
      },
    );
  }
}
