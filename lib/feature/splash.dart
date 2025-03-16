import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_bloc.dart';
import 'package:task_project/feature/auth/presentation/screens/signin.dart';
import 'package:task_project/feature/investment/presentation/screens/investment_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      final user = context.read<AuthBloc>().signInUseCase.repository.getCurrentUser();
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InvestmentListScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}