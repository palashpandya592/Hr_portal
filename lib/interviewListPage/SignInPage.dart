
import 'package:flutter/material.dart';
import 'package:interviewapp/main.dart';

class signInPage extends StatefulWidget {
  const signInPage({Key? key}) : super(key: key);

  @override
  _signInPageState createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _conformpassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("SignUp Screen"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.lightBlueAccent.withOpacity(0.7),
                  Colors.purpleAccent.withOpacity(0.5),

                ],
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white,width: 1.5)
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                      controller: _conformpassword,
                      textAlign: TextAlign.left,
                      decoration:  const InputDecoration(
                          border: InputBorder.none,
                          labelText:" Conform Password",
                          icon:  Icon(
                            Icons.lock,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width:  150,
                height:  35,
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
                        Text("Singup",style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    onPressed: () {
                    }),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do You Already have a Account?"),
                  TextButton(
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp()));
                      }
                  )
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
