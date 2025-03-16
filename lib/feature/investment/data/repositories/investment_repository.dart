import 'package:task_project/feature/investment/data/data_sources/investment_remote_data_source.dart';
import 'package:task_project/feature/investment/domain/entities/investment.dart';
import 'package:task_project/feature/investment/domain/repositories/investment_repository.dart';


class InvestmentModelRepository implements InvestmentRepository{  
  final InvestmentRemoteDataSource investmentRemoteDataSource;

  const InvestmentModelRepository({required this.investmentRemoteDataSource});  

  @override
  Future<List<Investment>> getInvestments(int page) async {  
    final investmentModels = await investmentRemoteDataSource.fetchInvestments(page);  
    return investmentModels.map((model) => Investment(  

      country: model.country,  
      zipCode: model.zipCode,  
      state: model.state,  
      street: model.state,  
      image: model.image, houseNumber: model.houseNumber,  
    )).toList();  
  }  
}