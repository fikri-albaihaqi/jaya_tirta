import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:jaya_tirta/utils/validator.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../main_screen/main_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      // If email is valid adding new Event [SignInRequested].
      BlocProvider.of<AuthenticationBloc>(context).add(
        LogInRequested(_emailTextController.text, _passwordTextController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            }
            if (state is AuthError) {
              // Showing the error message if the user has entered invalid credentials
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Loading) {
                // Showing the loading indicator while the user is signing in
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UnAuthenticated) {
                // Showing the sign in form if the user is not authenticated
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('graphics/login-bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView(
                    reverse: true,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 350,
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 24.0, right: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 24.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Kanit',
                                    fontWeight: FontWeight.w700,
                                    color: kJayaTirtaBlack900,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _emailTextController,
                                      focusNode: _focusEmail,
                                      validator: (value) =>
                                          Validator.validateEmail(
                                        email: value,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _passwordTextController,
                                      focusNode: _focusPassword,
                                      obscureText: true,
                                      validator: (value) =>
                                          Validator.validatePassword(
                                        password: value,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.0),
                                    _isProcessing
                                        ? CircularProgressIndicator()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _authenticateWithEmailAndPassword(
                                                        context);
                                                  },
                                                  child: const Text(
                                                    'Login',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
