import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/auth_state.dart';
import 'package:instagram_planner/profile/presentation/profile_page.dart';
import 'package:instagram_planner/providers.dart';

import 'signup_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Nasłuchujemy na zmiane stanu, aby przekierować użytkownika do profilu ( nie przebudowywujemy widgetu)
    // prevoius - poprzedni stan, next - następny stan
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 7, 102),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                ref
                    .read(authProvider.notifier)
                    .login(_emailController.text, _passwordController.text);
                print(
                    'Email: ${_emailController.text}, Password: ${_passwordController.text}');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              // jesli stan jest w trakcie ładowania to pokazujemy kółko ładowania, w przeciwnym wypadku pokazujemy napis
              child: authState.isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : const Text('Login', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateAccount(),
                  ),
                );
              },
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
