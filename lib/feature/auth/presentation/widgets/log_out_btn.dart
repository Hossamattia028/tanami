import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_bloc.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_event.dart';
import 'package:task_project/feature/auth/presentation/blocs/auth_state.dart';
import 'package:task_project/feature/auth/presentation/screens/signin.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pop();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
        }
      },
      child: BlocBuilder<AuthBloc,AuthState>(
        builder: (ctx,state) {
          var bloc = AuthBloc.get(ctx);
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => bloc.add(SignOutEvent()),
                child: const Text('Logout'),
              ),
            ],
          );
        }
      ),
    );
  }
}
