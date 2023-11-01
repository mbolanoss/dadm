import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/providers/company_provider.dart';
import 'package:reto_8/services/db_service.dart';
import 'package:reto_8/widgets/company_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbService = context.read<DBService>();
    final textTheme = Theme.of(context).textTheme;
    final companyProvider = context.watch<CompanyProvider>();

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Lista de empresas',
                style: textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: companyProvider.getCompaniesListLength(),
                  itemBuilder: (_, index) {
                    return CompanyCard(
                        company: companyProvider.companiesList[index]);
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
            right: 20,
          ),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}

// ElevatedButton(
//                 onPressed: () async {
//                   await dbService.insertCompany(
//                     Company(
//                         name: 'CompanyTest',
//                         url: 'Url test',
//                         phoneNumber: 111222333,
//                         email: 'email test',
//                         services: 'services test',
//                         type: CompanyType.dev),
//                   );
//                 },
//                 child: const Text('Insert'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final list = await dbService.getAllCompanies();

//                   for (Company c in list) {
//                     print(c.toString());
//                   }
//                 },
//                 child: const Text('Fetch'),
//               ),
