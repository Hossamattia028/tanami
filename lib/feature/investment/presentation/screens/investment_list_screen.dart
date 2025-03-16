import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/auth/presentation/widgets/log_out_widget.dart';
import 'package:task_project/feature/investment/presentation/blocs/investment_bloc.dart';
import 'package:task_project/feature/investment/presentation/widgets/investment_tile.dart';  
import '../widgets/loading_indicator.dart';  

class InvestmentListScreen extends StatefulWidget {  
  const InvestmentListScreen({super.key});  

  @override  
  State<InvestmentListScreen> createState() => _InvestmentListScreenState();  
}  

class _InvestmentListScreenState extends State<InvestmentListScreen> {  
  final int _currentPage = 1; 
  final bool _isLoadingMore = false; 
  final ScrollController _scrollController = ScrollController();  

  @override  
  void initState() {  
    super.initState();  
  
    BlocProvider.of<InvestmentBloc>(context).add(FetchInvestments(_currentPage));  

    // _scrollController.addListener(() {  
    //   if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {  
    //     _loadMoreInvestments();  
    //   }  
    // });  
  }  


  //// this section will be enahnce by bloc flow and bloc states

  // void _loadMoreInvestments() {  
  //   setState(() {  
  //     _isLoadingMore = true; 
  //   });  
    
  //   _currentPage++; // Increment the current page  
  //   BlocProvider.of<InvestmentBloc>(context).add(FetchInvestments(_currentPage));  
  // }  

  @override  
  void dispose() {  
    _scrollController.dispose(); // Dispose of the controller  
    super.dispose();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Investments'),  
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
          ),
        ],
      ),  
      body: RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: BlocBuilder<InvestmentBloc, InvestmentState>(  
          builder: (context, state) {  
            if (state.loading) return const LoadingIndicator();  
            if (state.error != null) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 500,top: 200),
                child: Center(child: Text(state.error!,textAlign: TextAlign.center,)),
              );
            }  
            return ListView.builder(  
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 20),
              controller: _scrollController,  
              itemCount: state.investments.length + (_isLoadingMore ? 1 : 0), // Add 1 for loading indicator if loading more  
              itemBuilder: (context, index) {  
                if (index >= state.investments.length) {  
                  return const Center(child: CircularProgressIndicator()); // Show loading indicator at the end  
                }  
        
                final investment = state.investments[index];  
                return InvestmentTile(investment: investment);  
              },  
            );  
          },  
        ),
      ),  
    );  
  }  
  
  Future onRefresh()async{
    BlocProvider.of<InvestmentBloc>(context).add(FetchInvestments(_currentPage)); 
  }
}