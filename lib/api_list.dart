import 'package:flutter/material.dart';

import 'api_code.dart';

class APIList extends StatefulWidget {
  const APIList({super.key});

  @override
  State<APIList> createState() => _APIListState();
}

class _APIListState extends State<APIList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Demo"),),
      body: FutureBuilder(future: APICode().getDetails(), builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(snapshot.data![index].userName),
                IconButton(onPressed: () async {
                    await APICode().deleteUser(snapshot.data![index].userID).then((value) {
                      setState(() {

                      });
                    });
                }, icon: Icon(Icons.delete))
              ],
            );
          },);
        }
        else{
          return CircularProgressIndicator();
        }
      },),
    );
  }
}
