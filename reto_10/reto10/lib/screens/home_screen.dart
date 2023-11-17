import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto10/services/api_service.dart';
import 'package:reto10/utils/custom_theme.dart';

import '../widgets/segment_filter_section.dart';
import '../widgets/tech_filter_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final apiService = context.watch<ApiService>();
    // final buttonTheme = Theme.of(context).elevatedButtonTheme;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Datos: ${apiService.data.length} filas',
                      style: textTheme.displayLarge,
                      textAlign: TextAlign.center,
                    ),
                    const ColumnDivider(),
                  ],
                ),
                const Column(
                  children: [
                    // Filtrar por tecnologia
                    TechnologyFilterSection(),
                    ColumnDivider(),
                    // Filtrar por segmento
                    SegmentFilterSection(),
                    ColumnDivider(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColumnDivider extends StatelessWidget {
  const ColumnDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 4,
    );
  }
}
