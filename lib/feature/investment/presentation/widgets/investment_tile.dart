import 'package:flutter/material.dart';
import 'package:task_project/feature/investment/domain/entities/investment.dart';
import 'package:task_project/feature/investment/presentation/screens/investment_details_screen.dart';  

class InvestmentTile extends StatelessWidget {  
  final Investment investment;  

  const InvestmentTile({super.key, required this.investment});  

  @override  
  Widget build(BuildContext context) {  
    return ListTile(  
      leading: Image.network(investment.image),  
      title: Text(investment.country),  
      subtitle: Text('${investment.street} - ${investment.zipCode}'),  
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InvestmentDetailsScreen(investment: investment)),
      ),  
    );  
  }  
}