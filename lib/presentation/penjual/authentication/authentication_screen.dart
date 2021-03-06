import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaya_tirta/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:jaya_tirta/utils/validator.dart';
import 'package:jaya_tirta/bloc/blocs.dart';

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

  final bool _isProcessing = false;

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        PenjualLogInRequested(
            _emailTextController.text, _passwordTextController.text),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UnAuthenticated) {
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
                                      maxLength: 75,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(75)
                                      ],
                                      validator: (value) =>
                                          Validator.validateEmail(
                                        email: value,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        counterText: '',
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _passwordTextController,
                                      focusNode: _focusPassword,
                                      obscureText: true,
                                      maxLength: 50,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(50)
                                      ],
                                      validator: (value) =>
                                          Validator.validatePassword(
                                        password: value,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        counterText: '',
                                        errorBorder: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24.0),
                                    _isProcessing
                                        ? const CircularProgressIndicator()
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
