import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watcher_app/constants.dart';
import 'package:watcher_app/controllers/screen.dart';
import 'package:watcher_app/screens/auth/auth_bloc.dart';
import 'have_account.dart';
import 'signup_screen.dart';
import 'package:watcher_app/screens/topbar.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TopBar(),
            ),
          );
        }
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Column(
        children: [
          TextFormField(
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            controller: emailEditingController,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email");
              }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please Enter a valid email");
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.mail),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              autofocus: false,
              controller: passwordEditingController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) {
                RegExp regex = RegExp(r'^.{6,}$');
                if (value!.isEmpty) {
                  return ("Password is required");
                }
                if (!regex.hasMatch(value)) {
                  return ("Enter Valid Password(Min. 6 Character)");
                }
              },
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.vpn_key),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "loginButton",
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(
                      LoginWithEmailAndPasswordEvent(
                        email: emailEditingController.text,
                        password: passwordEditingController.text,
                      ),
                    );
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
