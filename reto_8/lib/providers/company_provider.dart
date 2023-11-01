import 'package:flutter/material.dart';
import 'package:reto_8/models/company.dart';
import 'package:reto_8/services/db_service.dart';

class CompanyProvider with ChangeNotifier {
  late DBService dbService;
  List<Company> companiesList = <Company>[];

  Company getCompanyFromIndex(int index) {
    return companiesList[index];
  }

  int getCompaniesListLength() {
    return companiesList.length;
  }

  Future<void> addCompany(Company company) async {
    final id = await dbService.insertCompany(company);
    company.id = id;
    companiesList.add(company);
    notifyListeners();
  }

  Future<void> deleteCompany(Company company) async {
    companiesList.removeWhere((Company c) => c.id == company.id);
    await dbService.deleteCompany(company);
    notifyListeners();
  }

  Future<void> updateCompany(Company company) async {
    final index = companiesList.indexWhere((Company c) => c.id == company.id);
    companiesList[index] = company;

    await dbService.updateCompany(company);

    notifyListeners();
  }

  Future<void> fetchAllCompanies() async {
    final newList = await dbService.getAllCompanies();
    companiesList = newList;

    notifyListeners();
  }
}
