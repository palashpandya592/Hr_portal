
import 'package:flutter/material.dart';

class ReviewerDropDown extends StatefulWidget {
  const ReviewerDropDown({Key? key}) : super(key: key);

  @override
  _ReviewerDropDownState createState() => _ReviewerDropDownState();
}

class _ReviewerDropDownState extends State<ReviewerDropDown> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
