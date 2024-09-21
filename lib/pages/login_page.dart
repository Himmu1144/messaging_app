import 'package:flutter/material.dart';
import 'package:mimiko/services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(BuildContext context) async {
    // first get the auth service here
    final authService = AuthService();

    // now try login and handle all the errors
    try {
      await authService.signInWithEmailPass(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 0,
                  ),

                  // logo
                  Icon(
                    Icons.flood,
                    size: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // welcome msg
                  Text(
                    'Welcome back, nobody misses you!',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),

                  // Email field
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 35.0, right: 35, top: 20),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          fillColor: Theme.of(context).colorScheme.secondary,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary)),
                    ),
                  ),

                  // password field
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 35.0, right: 35, top: 20),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        fillColor: Theme.of(context).colorScheme.secondary,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),

                  // forgot password
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 35, top: 5, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),

                  // Sign in Button
                  GestureDetector(
                    onTap: () => login(context),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // create an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
