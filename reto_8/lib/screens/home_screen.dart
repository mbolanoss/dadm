import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/providers/company_provider.dart';
import 'package:reto_8/utils/custom_theme.dart';
import 'package:reto_8/widgets/company_card.dart';

import '../models/company.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTheme = Theme.of(context).elevatedButtonTheme;

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
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 40,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: companyProvider.getCompaniesListLength(),
                  itemBuilder: (_, index) {
                    return CompanyCard(
                        company: companyProvider.companiesList[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
              BottomButtons(buttonTheme: buttonTheme, textTheme: textTheme),
              // ElevatedButton(
              //   onPressed: () async {
              //     await companyProvider.addCompany(
              //       Company(
              //           name: 'CompanyTest',
              //           url: 'Url test',
              //           phoneNumber: 111222333,
              //           email: 'email test',
              //           services: 'services test',
              //           type: CompanyType.dev),
              //     );
              //   },
              //   child: const Text('Insert'),
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //     final list = await companyProvider.getAllCompanies();
              //     for (Company c in list) {
              //       print(c.toString());
              //     }
              //   },
              //   child: const Text('Fetch'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.buttonTheme,
    required this.textTheme,
  });

  final ElevatedButtonThemeData buttonTheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: buttonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all(purple),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/handleCompany');
          },
          child: Container(
            padding: const EdgeInsets.all(7),
            child: Text(
              'Crear',
              style: textTheme.labelLarge,
            ),
          ),
        ),
        IconButton(
          style: buttonTheme.style!,
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
          iconSize: 35,
        ),
        IconButton(
          style: buttonTheme.style!,
          onPressed: () {},
          icon: const Icon(Icons.close_rounded),
          iconSize: 35,
        ),
      ],
    );
  }
}
