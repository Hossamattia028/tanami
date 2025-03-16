import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';  
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_bloc.dart';
import 'package:task_project/feature/investment/presentation/blocs/investment_bloc.dart';

import 'package:task_project/feature/splash.dart';
import 'package:task_project/injection_container.dart';  
import 'injection_container.dart' as di;

void main() async{  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  debugPrint = (String? message, {int? wrapWidth}) {};
  runApp(const MyApp());  
}  

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override  
  Widget build(BuildContext context) {  
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => sl<InvestmentBloc>()),
          BlocProvider(create: (ctx) => sl<AuthBloc>()),
        ],
        child: MaterialApp(
         debugShowCheckedModeBanner: false,
          builder: (BuildContext? context, Widget? widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              return const SizedBox();
            };
            return widget!;
          },
          title: 'Rick and Morty',
          home: const SplashScreen(),
        ),
      );  
  }  
}



