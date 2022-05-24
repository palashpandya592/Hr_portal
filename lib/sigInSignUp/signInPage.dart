import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interviewapp/main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _conformPassword = TextEditingController();

  static Future<User?>? createAccountWithEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak-password");
      } else if (e.code == 'email-already-in-use') {
        print("email-already-in-use");
      } else if (e.code == 'user-not-found') {
        print("user-not-found");
      } else if (e.code == 'wrong-password') {
        print("Wrong Password");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.white
              /*gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.lightBlueAccent.withOpacity(0.7),
                  Colors.purpleAccent.withOpacity(0.5),

                ],
              )*/
              ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("HR-Interview App", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const Text("SignUp to Your App", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                      controller: _name,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: "UserName",
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
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                      controller: _username,
                      textAlign: TextAlign.left,
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
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                      obscureText: true,
                      controller: _password,
                      textAlign: TextAlign.left,
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
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                      obscureText: true,
                      controller: _conformPassword,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: " Conform Password",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: const [
                          Text("Sing Up", style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      onPressed: () async {
                        User? user =
                            await createAccountWithEmailPassword(email: _username.text.trim(), password: _password.text.trim(), context: context);
                        print("required ${user}");
                        if (user != null) {
                          if (_password.text == _conformPassword.text) {
                            _showDialog();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords are not Matching...')));
                          }
                        } else {}
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
