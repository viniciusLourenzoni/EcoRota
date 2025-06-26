import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../componentes/mapa_localizacao.dart';
import '../componentes/postos_proximos.dart';

class Postos extends StatefulWidget {
  const Postos({super.key});

  @override
  State<Postos> createState() => _PostosState();
}

class _PostosState extends State<Postos> {
  Position? _posicaoAtual;

  @override
  void initState() {
    super.initState();
    _obterLocalizacao();
  }

  Future<void> _obterLocalizacao() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final pos = await Geolocator.getCurrentPosition();
        setState(() => _posicaoAtual = pos);
      }
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_posicaoAtual == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(flex: 2, child: MapaLocalizacao(posicao: _posicaoAtual!)),
        Expanded(flex: 3, child: PostosProximos(posicao: _posicaoAtual!)),
      ],
    );
  }
}
