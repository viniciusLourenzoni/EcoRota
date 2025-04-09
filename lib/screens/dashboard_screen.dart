import 'package:flutter/material.dart';
import '../widgets/stats_card.dart';
import '../widgets/consumption_chart.dart';
import '../widgets/price_history.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatsCard(),
          const SizedBox(height: 20),
          const ConsumptionChart(),
          const SizedBox(height: 20),
          const PriceHistory(),
        ],
      ),
    );
  }
}