import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/models/company.dart';

import '../providers/company_provider.dart';
import '../utils/custom_theme.dart';

// ignore: must_be_immutable
class HandleCompany extends StatelessWidget {
  Company? currentCompany;

  HandleCompany({super.key, this.currentCompany});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Crear empresa',
                    style: textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  HandleCompanyForm(currentCompany: currentCompany),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HandleCompanyForm extends StatelessWidget {
  Company? currentCompany;
  final formKey = GlobalKey<FormState>();
  final nameFieldController = TextEditingController();
  final urlFieldController = TextEditingController();
  final phoneFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final servicesFieldController = TextEditingController();
  CompanyType? selectedCompanyType;

  HandleCompanyForm({
    super.key,
    this.currentCompany,
  });

  void clearForm() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTheme = Theme.of(context).elevatedButtonTheme;
    final companyProvider = context.watch<CompanyProvider>();

    if (currentCompany != null) {
      nameFieldController.text = currentCompany!.name;
      urlFieldController.text = currentCompany!.url;
      phoneFieldController.text = currentCompany!.phoneNumber.toString();
      emailFieldController.text = currentCompany!.email;
      servicesFieldController.text = currentCompany!.services;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          FormInput(
            controller: nameFieldController,
            hint: 'Nombre',
            icon: Icons.person,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingrese un nombre';
              }
              return null;
            },
          ),
          FormInput(
            controller: urlFieldController,
            hint: 'Url',
            icon: Icons.link,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingrese un url';
              }
              return null;
            },
          ),
          FormInput(
            controller: phoneFieldController,
            hint: 'Teléfono',
            icon: Icons.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingrese un teléfono';
              }
              return null;
            },
            inputType: TextInputType.number,
          ),
          FormInput(
            controller: emailFieldController,
            hint: 'Email',
            icon: Icons.email,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingrese un email';
              }
              return null;
            },
          ),
          FormInput(
            controller: servicesFieldController,
            hint: 'Servicios',
            icon: Icons.settings,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Ingrese los servicios';
              }
              return null;
            },
          ),
          CompanyTypeDropdown(
            changeFormValue: (newType) => selectedCompanyType = newType,
            preSelectedType:
                currentCompany != null ? currentCompany!.type : null,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (currentCompany == null) {
                  Company newCompany = Company(
                    name: nameFieldController.text,
                    url: urlFieldController.text,
                    phoneNumber: int.parse(phoneFieldController.text),
                    email: emailFieldController.text,
                    services: servicesFieldController.text,
                    type: selectedCompanyType!,
                  );
                  await companyProvider.addCompany(newCompany);
                } else {
                  currentCompany!.name = nameFieldController.text;
                  currentCompany!.url = urlFieldController.text;
                  currentCompany!.phoneNumber =
                      int.parse(phoneFieldController.text);
                  currentCompany!.email = emailFieldController.text;
                  currentCompany!.services = servicesFieldController.text;
                  currentCompany!.type = selectedCompanyType!;
                  await companyProvider.updateCompany(currentCompany!);
                }

                // ignore: use_build_context_synchronously
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        currentCompany == null
                            ? 'Empresa creada correctamente'
                            : 'Empresa actualizada correctamente',
                        style: textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            clearForm();
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                          child: Text(
                            'Ok',
                            style: textTheme.displaySmall,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text(
              currentCompany == null ? 'Crear' : 'Actualizar',
              style: textTheme.labelLarge!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              clearForm();
              Navigator.of(context).pushReplacementNamed('/');
            },
            style: buttonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            child: Text(
              'Volver',
              style: textTheme.labelLarge!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CompanyTypeDropdown extends StatelessWidget {
  final void Function(CompanyType) changeFormValue;
  CompanyType? preSelectedType;

  CompanyTypeDropdown({
    super.key,
    required this.changeFormValue,
    this.preSelectedType,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        const Icon(Icons.category, size: 35),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: DropdownButtonFormField<CompanyType>(
            value: preSelectedType,
            validator: (type) {
              if (type == null) {
                return 'Selecciona un tipo de empresa';
              }
              return null;
            },
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
            ],
            onChanged: (value) {
              changeFormValue(value!);
            },
          ),
        ),
      ],
    );
  }
}

class FormInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType inputType;
  const FormInput({
    super.key,
    required this.icon,
    required this.hint,
    required this.validator,
    required this.controller,
    this.inputType = TextInputType.emailAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 35),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextFormField(
            controller: controller,
            cursorColor: blue,
            decoration: InputDecoration(
              hintText: hint,
            ),
            validator: validator,
            keyboardType: inputType,
          ),
        ),
      ],
    );
  }
}
