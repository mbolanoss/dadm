import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/db_entry.dart';
import '../services/api_service.dart';

class SegmentFilterSection extends StatefulWidget {
  const SegmentFilterSection({
    super.key,
  });

  @override
  State<SegmentFilterSection> createState() => _SegmentFilterSectionState();
}

class _SegmentFilterSectionState extends State<SegmentFilterSection> {
  Segment selectedSegment = Segment.EMPRESAS;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final apiService = context.watch<ApiService>();
    final buttonTheme = Theme.of(context).elevatedButtonTheme;

    return Column(
      children: [
        Text(
          'Filtrar por segmento',
          style: textTheme.displaySmall,
        ),
        DropdownButton<Segment>(
          value: selectedSegment,
          items: [
            DropdownMenuItem(
              value: Segment.EMPRESAS,
              child: Text(
                'Empresas',
                style: textTheme.bodyLarge,
              ),
            ),
            DropdownMenuItem(
              value: Segment.PERSONAS,
              child: Text(
                'Personas',
                style: textTheme.bodyLarge,
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedSegment = value!;
            });
          },
        ),
        ElevatedButton(
          onPressed: () async {
            apiService.changeFilter(
              FilterType.segment,
            );

            await apiService.fetchBySegment(selectedSegment);
          },
          style: buttonTheme.style,
          child: Text(
            'Filtrar',
            style: textTheme.labelLarge!.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
