// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_bloc.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_event.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_state.dart';
import 'package:task_project/feature/auth/presentation/screens/signup.dart';
import 'package:task_project/feature/investment/presentation/screens/investment_list_screen.dart';


class SignInScreen extends StatelessWidget {
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is Authenticated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InvestmentListScreen()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.read<AuthBloc>().add(SignInEvent(emailController.text, passwordController.text)),
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                child: const Text('Don’t have an account? Sign Up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
