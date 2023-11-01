import 'package:flutter/material.dart';
import 'package:reto_8/models/company.dart';

class CompanyProvider with ChangeNotifier {
  List<Company> companiesList = List.empty(growable: false);

  Company getCompanyFromIndex(int index) {
    return companiesList[index];
  }

  int getCompaniesListLength() {
    return companiesList.length;
  }

  void addCompanyToList(Company company) {
    companiesList.add(company);
    notifyListeners();
  }

  void removeCompanyFromList(Company company) {
    companiesList.removeWhere((Company c) => c.id == company.id);
    notifyListeners();
  }

  void updateCompanyFromList(Company company) {
    final index = companiesList.indexWhere((Company c) => c.id == company.id);
    companiesList[index] = company;

    notifyListeners();
  }
}
