import 'package:flutter/material.dart';
import '../widgets/monthly_report.dart';
import '../widgets/yearly_report.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Mensal'),
              Tab(text: 'Anual'),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                MonthlyReport(),
                YearlyReport(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}