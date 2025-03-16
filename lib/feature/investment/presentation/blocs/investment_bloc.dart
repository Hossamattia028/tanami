import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/investment/domain/entities/investment.dart';
import 'package:task_project/feature/investment/domain/usecases/get_investments.dart';  


class InvestmentState {  
  final List<Investment> investments;  
  final bool loading;  
  final String? error;  

  const InvestmentState({this.investments = const [], this.loading = false, this.error});  
}  

class InvestmentEvent {}  

class FetchInvestments extends InvestmentEvent {  
  final int page;  

  FetchInvestments(this.page);  
} 

class InvestmentBloc extends Bloc<InvestmentEvent, InvestmentState> {  
 

  final GetInvestmentsUseCase getInvestmentsUseCase;  

  List<Investment> investments = [];

  InvestmentBloc(this.getInvestmentsUseCase) : super(const InvestmentState()) {  
    on<FetchInvestments>((event, emit) async {  
      await getInvestments(event,emit);
    });  
  }  



  getInvestments(FetchInvestments event,emit)async{
    emit(const InvestmentState(loading: true)); // Start loading  
    try {  
      final list = await getInvestmentsUseCase(event.page);  
      investments.addAll(list);
      emit(InvestmentState(investments: [...state.investments, ...investments])); 
    } catch (e) {  
      emit(InvestmentState(error: e.toString())); // Handle error  
    } 
  }

}