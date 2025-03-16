
import 'package:task_project/feature/investment/domain/entities/investment.dart';

abstract class InvestmentRepository {
  Future<List<Investment>> getInvestments(int page);
}
