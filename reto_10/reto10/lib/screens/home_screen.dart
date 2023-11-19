import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto10/services/api_service.dart';
import 'package:reto10/utils/custom_theme.dart';
import 'package:reto10/widgets/legend.dart';
import 'package:reto10/widgets/graphic.dart';

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
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grafico
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Datos: ${apiService.data.length} filas',
                    style: textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const AspectRatio(
                    aspectRatio: 1.5,
                    child: Graphic(),
                  ),
                  const SizedBox(height: 10),
                  const Legend(),
                  const SizedBox(height: 10),
                ],
              ),
              // Filtros
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    // Filtrar por tecnologia
                    TechnologyFilterSection(),
                    ColumnDivider(),
                    // Filtrar por segmento
                    SegmentFilterSection(),
                    ColumnDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GraphicWrapper extends StatelessWidget {
  const GraphicWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final apiService = context.watch<ApiService>();
    switch (apiService.filter) {
      case FilterType.technology:
        return const AspectRatio(
          aspectRatio: 1.6,
          child: Graphic(),
        );
      case FilterType.segment:
        return Container(
          color: red,
          height: 300,
        );
      case FilterType.supplier:
        return Container(
          color: Colors.green,
          height: 300,
        );

      case FilterType.none:
        return const Icon(
          Icons.dashboard,
          size: 150,
          color: purple,
        );
    }
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
