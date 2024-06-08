import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:server_todo/repositories/company/company_repository.dart';
import 'package:server_todo/repositories/company/i_company_repository.dart';

///
Handler companyMiddleware(Handler handler) {
  return (context) async {
    final conection = context.read<Connection>();
    final companyRepository = CompanyRepository(connection: conection);
    return handler
        .use(
          provider<ICompanyRepository>((_) => companyRepository),
        )
        .call(context);
  };
}
