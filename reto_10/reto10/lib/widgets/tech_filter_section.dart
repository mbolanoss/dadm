import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/db_entry.dart';
import '../services/api_service.dart';

class TechnologyFilterSection extends StatefulWidget {
  const TechnologyFilterSection({
    super.key,
  });

  @override
  State<TechnologyFilterSection> createState() =>
      _TechnologyFilterSectionState();
}

class _TechnologyFilterSectionState extends State<TechnologyFilterSection> {
  Technology selectedTech = Technology.THE_2_G;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final apiService = context.watch<ApiService>();
    final buttonTheme = Theme.of(context).elevatedButtonTheme;

    return Column(
      children: [
        Text(
          'Filtrar por tecnología',
          style: textTheme.displaySmall,
        ),
        DropdownButton<Technology>(
          value: selectedTech,
          items: [
            DropdownMenuItem(
              value: Technology.THE_2_G,
              child: Text(
                '2G',
                style: textTheme.bodyLarge,
              ),
            ),
            DropdownMenuItem(
              value: Technology.THE_3_G,
              child: Text(
                '3G',
                style: textTheme.bodyLarge,
              ),
            ),
            DropdownMenuItem(
              value: Technology.THE_4_G,
              child: Text(
                '4G',
                style: textTheme.bodyLarge,
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedTech = value!;
            });
          },
        ),
        ElevatedButton(
          onPressed: () async {
            apiService.changeFilter(
              FilterType.technology,
            );

            await apiService.fetchByTechnology(selectedTech);
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
