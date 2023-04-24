import 'package:flutter/material.dart';
import 'package:watcher_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watcher_app/controllers/screen.dart';
import 'package:watcher_app/screens/auth/auth_bloc.dart';
import 'package:watcher_app/screens/sidebar.dart';
import 'have_account.dart';
import 'login_screen.dart';

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);

  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Sidebar(),
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
          //First Name
          TextFormField(
            autofocus: false,
            controller: firstNameEditingController,
            keyboardType: TextInputType.name,
            enableSuggestions: false,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              //  RegExp regex = new RegExp(r'^.{1,}$');
              if (value!.isEmpty) {
                return ("First Name cannot be Empty");
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "First Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          //Last Name
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            autofocus: false,
            controller: lastNameEditingController,
            keyboardType: TextInputType.name,
            enableSuggestions: false,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              //  RegExp regex = new RegExp(r'^.{1,}$');
              if (value!.isEmpty) {
                return ("Last Name cannot be Empty");
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Last Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          //Phone Number
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            autofocus: false,
            controller: phoneNumberEditingController,
            keyboardType: TextInputType.phone,
            enableSuggestions: false,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Phone Number");
              }
              if (!RegExp(r'^(09|\+639)\d{9}$').hasMatch(value)) {
                return ("Please Enter a valid number");
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Phone Number",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone),
              ),
            ),
          ),

          //Email
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            autofocus: false,
            controller: emailEditingController,
            keyboardType: TextInputType.emailAddress,
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
              hintText: "Email Address",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),

          //Password
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            autofocus: false,
            controller: passwordEditingController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: kPrimaryColor,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ("Password is required for login");
              }
              if (!regex.hasMatch(value)) {
                return ("Enter Valid Password(Min. 6 Character)");
              }
            },
            decoration: const InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),

          //Confirm Password
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            autofocus: false,
            controller: confirmPasswordEditingController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (confirmPasswordEditingController.text !=
                  passwordEditingController.text) {
                return "Password don't match";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(
                    CreateAccountEvent(
                      firstName: firstNameEditingController.text,
                      lastName: lastNameEditingController.text,
                      phoneNumber: phoneNumberEditingController.text,
                      email: emailEditingController.text,
                      password: passwordEditingController.text,
                    ),
                  );
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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
