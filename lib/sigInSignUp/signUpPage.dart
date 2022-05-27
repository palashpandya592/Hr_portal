import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/main.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_bloc.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_events.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conformPassword = TextEditingController();
  AuthenticationBloc? _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("HR-Interview App", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const Text("SignUp to Your App", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                    controller: _name,
                    textAlign: TextAlign.left,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter UserName';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'UserName',
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.account_circle,color: Colors.blue), //make the icon also change its color
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                    controller: _emailController,
                    textAlign: TextAlign.left,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length > 4 && value.contains('@') && value.endsWith('.com')) {
                        return null;
                      } else {
                        return 'Enter Valid EmailId';
                      }
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.account_circle,color: Colors.blue), //make the icon also change its color
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                    obscureText: true,
                    controller: _password,
                    textAlign: TextAlign.left,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'weak Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.lock,color: Colors.blue), //make the icon also change its color
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                    obscureText: true,
                    controller: _conformPassword,
                    textAlign: TextAlign.left,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'weak Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.lock,color: Colors.blue), //make the icon also change its color
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocProvider(
                  create: (context) => AuthenticationBloc(AuthenticationInitial()),
                  child: Builder(builder: (BuildContext context) {
                    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: BlocListener<AuthenticationBloc, AuthenticationState>(
                          listener: (context, state) {
                            if (state is AuthenticationSuccess) {
                              _showDialog();
                            }
                          },
                          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
                            if (state is AuthenticationInitial) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width - 20,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: const [
                                      Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  onPressed: () {
                                    if (validateForm(context: context)) {
                                      _authenticationBloc!.add(SignUpButtonEvent(email: _emailController.text, password: _password.text));
                                    }
                                  },
                                ),
                              );
                            } else if (state is AuthenticationLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is AuthenticationSuccess) {
                              return Container();
                            } else if (state is AuthenticationFailure) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width - 20,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: const [
                                      Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  onPressed: () {
                                    if (validateForm(context: context)) {
                                      _authenticationBloc!.add(SignUpButtonEvent(email: _emailController.text, password: _password.text));
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do You Already have a Account?"),
                    TextButton(
                        child: const Text('LogIn'),
                        onPressed: () {
                          navigateToLogInPage(context: context);
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          title: const Icon(Icons.check_circle_outline_rounded, size: 70, color: Colors.green),
          content: const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 6, 0),
            child: Text("SignUp Successfully...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Done'),
                onPressed: () {
                  navigateToLogInPage(context: context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  bool validateForm({required BuildContext context}) {
    if (_emailController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Email")));
      return false;
    } else if (_name.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter UserName")));
      return false;
    } else if (_password.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Conform Password")));
      return false;
    } else {
      return true;
    }
  }

  void navigateToLogInPage({BuildContext? context}) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const MyApp()));
  }
}
