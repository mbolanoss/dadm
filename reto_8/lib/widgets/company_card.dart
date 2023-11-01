import 'package:flutter/material.dart';
import 'package:reto_8/utils/custom_theme.dart';

import '../models/company.dart';

class CompanyCard extends StatelessWidget {
  final Company company;

  const CompanyCard({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final buttonTheme = Theme.of(context).elevatedButtonTheme;

    return Material(
      elevation: 7,
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompanyName(companyName: company.name),
            const SizedBox(height: 15),
            CompanyInfoItem(
              icon: Icons.link,
              info: company.url,
            ),
            const ItemDivider(),
            CompanyInfoItem(
              icon: Icons.phone,
              info: company.phoneNumber.toString(),
            ),
            const ItemDivider(),
            CompanyInfoItem(
              icon: Icons.email,
              info: company.email,
            ),
            const ItemDivider(),
            CompanyInfoItem(
              icon: Icons.settings,
              info: company.services,
            ),
            const ItemDivider(),
            CompanyInfoItem(
              icon: Icons.category,
              info: companyEnumToString(company.type),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: buttonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all(red)),
                  child: Container(
                    margin: EdgeInsets.all(4),
                    child: Text(
                      'Eliminar',
                      style: textTheme.labelLarge,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  style: buttonTheme.style!.copyWith(
                    backgroundColor: MaterialStateProperty.all(yellow),
                  ),
                  icon: const Icon(Icons.edit),
                  iconSize: 30,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ItemDivider extends StatelessWidget {
  const ItemDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 3,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class CompanyInfoItem extends StatelessWidget {
  const CompanyInfoItem({
    super.key,
    required this.icon,
    required this.info,
  });

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 35,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            info,
            style: textTheme.displaySmall,
            overflow: TextOverflow.fade,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

class CompanyName extends StatelessWidget {
  const CompanyName({
    super.key,
    required this.companyName,
  });

  final String companyName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: blue,
      ),
      child: Text(
        companyName,
        style: textTheme.displaySmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
