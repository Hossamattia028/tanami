import 'package:task_project/feature/investment/domain/entities/investment.dart';
import 'package:task_project/feature/investment/domain/repositories/investment_repository.dart';


class GetInvestmentsUseCase {  
  final InvestmentRepository repository;  

  const GetInvestmentsUseCase(this.repository);  

  Future<List<Investment>> call(int page) async {  
    return await repository.getInvestments(page);  
  }  
}