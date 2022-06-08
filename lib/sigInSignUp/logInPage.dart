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
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpeg"),
              fit: BoxFit.fitHeight),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                     constraints: BoxConstraints.expand(height: 200.0),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Image.asset("assets/images/log_in.jpg",
                    fit: BoxFit.cover,
                  )),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,8,13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Welcome Back..", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Colors.grey)),

                          Text("Hr-Portal Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Padding(
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
                        decoration: InputDecoration(
                          hintText: ' EmailId',
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                             borderSide: const BorderSide(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                             borderSide: const BorderSide(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red,width: 1.5),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          prefixIcon: Icon(Icons.person,color: Colors.indigo), //make the icon also change its color
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: const OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red,width: 1.5),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                             borderSide: const BorderSide(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                             borderSide: const BorderSide(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          prefixIcon: Icon(Icons.lock,color: Colors.indigo,size: 23,), //make the icon also change its color
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
                                        primary: Colors.indigo,
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
                                        primary: Colors.indigo,
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
                            child: const Text('SignUp',style: TextStyle(color:  Colors.indigo,)),
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
