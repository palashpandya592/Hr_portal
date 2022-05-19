
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listScreen extends StatefulWidget {
  const listScreen({Key? key}) : super(key: key);

  @override
  _listScreenState createState() => _listScreenState();
}

class _listScreenState extends State<listScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Screen"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, position) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Person Name",style:TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 6,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Age:21"),
                            Text("Gender: F"),
                            Text("graducation: B.tech "),
                          ],
                        ),
                        SizedBox(height: 6,),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: 10),
      ),
      floatingActionButton: floatingButton(),
    );
  }
  Widget? floatingButton() {
    return Container(
      width: 140,
      height: 40,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.blue,
        child: Row(
          children: [
            SizedBox(width: 4),
            Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
              size: 15,
            ),
            SizedBox(width: 4),
            Text("Add Candidates"),
          ],
        ),
        onPressed: () {
        },
      ),
    );
  }
}
