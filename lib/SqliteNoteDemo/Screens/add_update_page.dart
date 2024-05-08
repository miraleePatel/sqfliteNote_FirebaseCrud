import 'package:demo_sqflite/SqliteNoteDemo/DataBase/note_db.dart';
import 'package:demo_sqflite/SqliteNoteDemo/Models/note_model.dart';
import 'package:demo_sqflite/SqliteNoteDemo/Screens/home_page.dart';
import 'package:demo_sqflite/SqliteNoteDemo/Widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddUpdatePage extends StatefulWidget {
  NoteModel? notedata;
  bool? isUpdate;
  AddUpdatePage({Key? key, this.isUpdate, this.notedata}) : super(key: key);

  @override
  State<AddUpdatePage> createState() => _AddUpdatePageState();
}

class _AddUpdatePageState extends State<AddUpdatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showupdateData();
  }

  showupdateData() {
    if (widget.isUpdate!) {
      titleController.text = widget.notedata!.title!;
      descriptionController.text = widget.notedata!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade800,
        title: widget.isUpdate!
            ? Text("Update Note")
            : Text(
                "Add Note",
              ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormFieldWidget(
                controller: titleController,
                hintText: "Title",
                hintStyle: const TextStyle(fontSize: 25),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title is Empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormFieldWidget(
                controller: descriptionController,
                hintText: "Description",
                hintStyle: const TextStyle(fontSize: 20),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description is Empty";
                  }
                  return null;
                },
                maxLines: 5,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 7.h,
                  width: 90.w,

                  decoration: BoxDecoration(
                      color: Colors.yellow.shade800,
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.isUpdate!) {
                          NoteDatabase().updateDb({
                            'title': titleController.text,
                            'description': descriptionController.text
                          }, widget.notedata!.id!);
                        } else {
                          NoteDatabase().insertDb({
                            'title': titleController.text,
                            'description': descriptionController.text
                          });
                        }

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Homepage()));
                      }
                    },
                    child: widget.isUpdate!
                        ? Text(
                            "Update",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white),
                          )
                        : Text(
                            "Save",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  )),
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
