import 'package:cruddemo/database.dart';
import 'package:cruddemo/insertStudent.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      body: FutureBuilder(
        future: db.copyPasteAssetFileToRoot(),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            return FutureBuilder(
              future: db.getDataFromStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return InsertStudent(map: snapshot.data![index],);
                            },)).then((value) {
                              setState(() {

                              });
                            });
                          },
                          tileColor: Colors.grey,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index]["name"].toString(),
                                  style: TextStyle(fontSize: 25)),
                              Text(snapshot.data![index]["cpi"].toString())
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              db
                                  .deleteStudent(int.parse(snapshot.data![index]
                                          ['studentID']
                                      .toString()))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text("NO Data Found");
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return InsertStudent();
            },
          )).then((value) {
            setState(() {

            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
