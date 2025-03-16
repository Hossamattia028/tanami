import 'dart:convert';  
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_project/feature/investment/data/models/investment_model.dart';  

class InvestmentRemoteDataSource {  
  final String baseUrl = 'https://rickandmortyapi.com/api/Investment';  

  Future<List<InvestmentModel>> fetchInvestments(int page) async { 
    List<InvestmentModel> investments = [];

    final response = await http.get(Uri.parse('https://api.mockapi.com/api/items?api_key=81395941b32043f89c5628a89c4894d7'));  

    debugPrint('fetchInvestments: ${response.body}'); 
    if (response.statusCode == 200) {  
      final data = json.decode(response.body);

      for (var item in data) {
        print(item);
        investments.add(InvestmentModel.fromJson(item));
      }
      return investments;
      
    // return (data as List)  
    //       .map((investment) => InvestmentModel.fromJson(investment))  
    //       .toList();  
    } else {  
      debugPrint('Failed to load Investments: ${response.statusCode} ');
      return []; 
    }  
  }  
}