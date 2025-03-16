import 'package:flutter/material.dart';
import 'package:task_project/feature/investment/domain/entities/investment.dart';  

class InvestmentDetailsScreen extends StatelessWidget {  
  final Investment investment;  

  const InvestmentDetailsScreen({super.key, required this.investment});  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text(investment.country)),  
      body: Column(  
        children: [  
          Image.network(investment.image),  
          Text('House Number: ${investment.houseNumber}'),  
          Text('Street: ${investment.street}'),  
          Text('State: ${investment.state}'),  
          Text('Zip Code: ${investment.zipCode}'),  
          Text('Country: ${investment.country}'), 
        ],  
      ),  
    );  
  }  
}