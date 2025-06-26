import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoConsumo extends StatelessWidget {
  const GraficoConsumo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Consumo Médio (L/100km)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      side: AxisSide.left,
                      axisNameWidget: const Text('L/100km'),
                      axisNameSize: 24,
                      drawBelowEverything: true,
                      axisNameFit: AxisNameFit.wrap,
                    ),
                    bottomTitles: AxisTitles(
                      side: AxisSide.bottom,
                      axisNameWidget: const Text('Abastecimentos'),
                      axisNameSize: 24,
                      drawBelowEverything: true,
                      axisNameFit: AxisNameFit.wrap,
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      spots: const [
                        FlSpot(0, 9.5),
                        FlSpot(1, 8.7),
                        FlSpot(2, 8.3),
                        FlSpot(3, 8.0),
                        FlSpot(4, 7.8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
