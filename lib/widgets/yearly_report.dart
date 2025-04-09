import 'package:flutter/material.dart';

class YearlyReport extends StatelessWidget {
  const YearlyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '2024',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildReportItem('Total Gasto', 'R\$ 3.592,50'),
                  _buildReportItem('Litros Abastecidos', '627,5 L'),
                  _buildReportItem('Preço Médio', 'R\$ 5,72/L'),
                  _buildReportItem('Consumo Médio', '8,7 L/100km'),
                  _buildReportItem('Quilômetros Rodados', '7.213 km'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}