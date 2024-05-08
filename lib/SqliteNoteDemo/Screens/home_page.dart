import 'package:demo_sqflite/SqliteNoteDemo/DataBase/note_db.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Models/note_model.dart';
import 'add_update_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List notelist=[];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShowData();
  }

  ShowData()async{
     var data = await NoteDatabase().selectDb();
     print(data);
     notelist = data.map((e)=>NoteModel.fromJson(e)).toList();
     setState(() {
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        automaticallyImplyLeading: false,
        title: const Text("Note"),
        centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddUpdatePage(
          isUpdate: false,
        )));

      },child: Icon(Icons.add,size: 40,),backgroundColor:Colors.yellow.shade800),

    body: ListView.builder(
        itemCount: notelist.length,
        itemBuilder: (context,index){return Card(
          elevation: 10,
         shadowColor: Colors.yellow.shade800,
          child: ListTile(
            title: Text(notelist[index].title!,style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(notelist[index].description!),
            trailing: Container(
              height: 5.h,
              width: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddUpdatePage(
                          notedata: notelist[index],
                          isUpdate: true,
                        )));
                      },
                      child: Icon(Icons.edit)),

                  GestureDetector(
                      onTap: ()async {
                        var data = await NoteDatabase().deleteDb(notelist[index].id!);
                        print(data);
                        setState(() {
                          ShowData();
                        });
                      },
                      child: Icon(Icons.delete)),
                ],
              ),
            ),
          ),
        );}),
    );
  }
}
