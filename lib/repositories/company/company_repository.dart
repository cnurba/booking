import 'package:postgres/postgres.dart';
import 'package:server_todo/models/company.dart';
import 'package:server_todo/models/failure.dart';
import 'package:server_todo/repositories/company/i_company_repository.dart';

///
class CompanyRepository implements ICompanyRepository {
  ///
  const CompanyRepository({required this.connection});

  final Connection connection;

  @override
  Future<(Failure, bool)> addAll(List<Company> companies) {
    // TODO: implement addAll
    throw UnimplementedError();
  }

  @override
  Future<(Failure, bool)> createTable() {
    // TODO: implement createTable
    throw UnimplementedError();
  }

  @override
  Future<(Failure, String)> getById(String uuid) async {
    return (Failure(code: 1, message: ""), "Привет");
  }
}
