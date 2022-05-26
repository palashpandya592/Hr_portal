import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/interviewScreen/interviewCandidateListPage.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_bloc.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_events.dart';
import 'package:interviewapp/sigInSignUp/blocs/authBloc/auth_state.dart';
import 'package:interviewapp/sigInSignUp/signUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  AuthenticationBloc? _authenticationBloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("HR-Interview App", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const Text("Login to Your App", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 1,
                        controller: _username,
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
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Email",
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 1,
                        obscureText: true,
                        controller: _password,
                        textAlign: TextAlign.left,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
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
                                navigateToInterviewListPage(context: context);
                              }
                              if (state is AuthenticationFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Valid Logins")));
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
                                        Text("Login", style: TextStyle(fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    onPressed: () {
                                      if (validateForm(context: context)) {
                                        _authenticationBloc!.add(LoginButtonEvent(email: _username.text, password: _password.text));
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
                                        Text("Login", style: TextStyle(fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    onPressed: () {
                                      if (validateForm(context: context)) {
                                        _authenticationBloc!.add(LoginButtonEvent(email: _username.text, password: _password.text));
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
                      const Text("Don't have a Account?"),
                      TextButton(
                          child: const Text('SignUp'),
                          onPressed: () {
                            navigateToSignUpPage(context: context);
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool validateForm({required BuildContext context}) {
    if (_username.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter EmailId")));
      return false;
    } else if (_password.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Enter Password")));
      return false;
    } else {
      return true;
    }
  }

  void navigateToInterviewListPage({BuildContext? context}) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const InterViewerCandidatePage()));
  }

  void navigateToSignUpPage({BuildContext? context}) {
    Navigator.push(context!, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }
}
