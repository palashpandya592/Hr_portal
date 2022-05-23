
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interviewapp/interviewListPage/listScreen.dart';
import 'package:interviewapp/interviewListPage/signInPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static Future<User?>? loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user =userCredential.user;
    }on FirebaseAuthException catch (e) {
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

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password =  TextEditingController();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("HR-Interview App",style: TextStyle(fontSize:15,fontWeight: FontWeight.w600)),
                const Text("Login to Your App",style: TextStyle(fontSize:25,fontWeight: FontWeight.w600)),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                      controller: _username,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText:"Email",
                          icon:  Icon(
                            Icons.person,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                      obscureText: true,
                      controller: _password,
                      textAlign: TextAlign.left,
                      decoration:  const InputDecoration(
                          border: InputBorder.none,
                          labelText:"Password",
                          icon:  Icon(
                            Icons.lock,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height:  40,
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
                          Text("Login",style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      onPressed:() async {
                        User? user = await loginUsingEmailPassword(
                            email: _username.text.trim(),
                            password: _password.text.trim(),
                            context: context);
                        print("required ${user}");
                        if(user != null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Login Successfully...')));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListScreen()));
                        }else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListScreen()));
                          const snackBar =  SnackBar(
                            content: Text('Login failed...'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have a Account?"),
                    TextButton(
                        child: Text('SignUp'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                        }
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
