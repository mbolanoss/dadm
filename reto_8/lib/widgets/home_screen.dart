import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/models/company.dart';
import 'package:reto_8/services/db_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbService = context.read<DBService>();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await dbService.insertCompany(
                    Company(
                        name: 'CompanyTest',
                        url: 'Url test',
                        phoneNumber: 111222333,
                        email: 'email test',
                        services: 'services test',
                        type: CompanyType.dev),
                  );
                },
                child: const Text('Insert'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final list = await dbService.getAllCompanies();

                  for (Company c in list) {
                    print(c.toString());
                  }
                },
                child: const Text('Fetch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
