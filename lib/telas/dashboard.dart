import 'package:flutter/material.dart';
import '../componentes/cartao_estatisticas.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CartaoEstatisticas(),
          SizedBox(height: 20),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
