import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            vertical: 15,
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
              const SizedBox(height: 15),

              SearchBottomSheet(),

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

// ignore: must_be_immutable
class SearchBottomSheet extends StatelessWidget {
  final nameFieldController = TextEditingController();
  CompanyType? companyType;

  SearchBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final companyProvider = context.watch<CompanyProvider>();

    final buttonTheme = Theme.of(context).elevatedButtonTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(
              Icons.person,
              size: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                controller: nameFieldController,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Icon(
              Icons.category,
              size: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            CompanyTypeSelection(
              changeFormValue: (newType) => companyType = newType,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              style: buttonTheme.style!,
              onPressed: () async {
                await companyProvider.searchCompanies(
                  nameFieldController.text,
                  companyType,
                );
              },
              icon: const Icon(Icons.search_rounded),
              iconSize: 35,
            ),
            IconButton(
              style: buttonTheme.style!,
              onPressed: () async {
                await companyProvider.fetchAllCompanies();
              },
              icon: const Icon(Icons.close_rounded),
              iconSize: 35,
            ),
          ],
        ),
      ],
    );
  }
}

class CompanyTypeSelection extends StatefulWidget {
  final void Function(CompanyType?) changeFormValue;
  const CompanyTypeSelection({
    super.key,
    required this.changeFormValue,
  });

  @override
  State<CompanyTypeSelection> createState() => _CompanyTypeSelectionState();
}

class _CompanyTypeSelectionState extends State<CompanyTypeSelection> {
  CompanyType? selectedValue;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButton<CompanyType>(
      value: selectedValue,
      iconSize: 0,
      isDense: false,
      hint: Text(
        'Tipo de empresa',
        style: GoogleFonts.nunito(
          color: blue,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      items: [
        DropdownMenuItem(
          value: CompanyType.consultory,
          child: Text(
            companyEnumToString(CompanyType.consultory),
            style: textTheme.displaySmall,
          ),
        ),
        DropdownMenuItem(
          value: CompanyType.dev,
          child: Text(
            companyEnumToString(CompanyType.dev),
            style: textTheme.displaySmall,
          ),
        ),
        DropdownMenuItem(
          value: CompanyType.factory,
          child: Text(
            companyEnumToString(CompanyType.factory),
            style: textTheme.displaySmall,
          ),
        ),
        DropdownMenuItem(
          value: null,
          child: Text(
            'Todos',
            style: textTheme.displaySmall,
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          widget.changeFormValue(value);
        });
      },
    );
  }
}
