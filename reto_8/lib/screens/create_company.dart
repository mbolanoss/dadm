import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_8/models/company.dart';

import '../providers/company_provider.dart';
import '../utils/custom_theme.dart';

class CreateCompany extends StatelessWidget {
  const CreateCompany({super.key});

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
                  HandleCompanyForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HandleCompanyForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  static final nameFieldController = TextEditingController();
  static final urlFieldController = TextEditingController();
  static final phoneFieldController = TextEditingController();
  static final emailFieldController = TextEditingController();
  static final servicesFieldController = TextEditingController();

  HandleCompanyForm({
    super.key,
  });

  void clearForm() {
    formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTheme = Theme.of(context).elevatedButtonTheme;
    final companyProvider = context.watch<CompanyProvider>();

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
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                Company newCompany = Company(
                  name: nameFieldController.text,
                  url: urlFieldController.text,
                  phoneNumber: int.parse(phoneFieldController.text),
                  email: emailFieldController.text,
                  services: servicesFieldController.text,
                  type: CompanyType.consultory,
                );

                await companyProvider.addCompany(newCompany);

                // ignore: use_build_context_synchronously
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        'Empresa creada correctamente',
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
              'Crear',
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
