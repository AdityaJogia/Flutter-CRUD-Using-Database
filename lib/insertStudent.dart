import 'package:cruddemo/database.dart';
import 'package:flutter/material.dart';

class InsertStudent extends StatefulWidget {
  InsertStudent({super.key, this.map});

  Map? map;

  @override
  State<InsertStudent> createState() => _InsertStudentState();
}

class _InsertStudentState extends State<InsertStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cpiController = TextEditingController();
  MyDatabase db = MyDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text =
        widget.map?['name'] == null ? "" : widget.map!['name'];
    cpiController.text = widget.map?['cpi'] == null ? "" : widget.map!['cpi'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Name"),
          ),
          TextFormField(
            controller: cpiController,
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.map == null) {
                  db
                      .insertStudent(
                          name: nameController.text, cpi: cpiController.text)
                      .then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  db
                      .updateStudent(
                          name: nameController.text,
                          cpi: cpiController.text,
                          id: widget.map!['studentID'])
                      .then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Submit"))
        ],
      ),
    );
  }
}
