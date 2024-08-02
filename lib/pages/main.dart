import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notesapp/service/firestore_service.dart';
import 'package:flutter/material.dart';

import 'my_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FireStoreService createService = FireStoreService();
  final TextEditingController createNotesController = TextEditingController();
  //make a dialogbox that lets us create the note
  void openNoteBox(String? docID) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: createNotesController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      //adda new note
                      if (docID == null) {
                        createService.addNote(createNotesController.text);
                      } else {
                        createService.updateNotes(
                            createNotesController.text, docID);
                      }
                      //clear the textcontroller after we add it
                      createNotesController.clear();
                      //go back after
                      Navigator.pop(context);
                    },
                    child: const Text('Хадгалах'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[400],
        leading: const FlutterLogo(),
        title: const Text('Тэмдэглэл'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyScreen()));
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/profile.JPG'),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: createService.getNotesStream(),
        builder: (context, snapshot) {
          //if we have data get all docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  //get each individual docs
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  //get note from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];
                  //display as a list tile
                  return ListTile(
                    title: Text(noteText, style: TextStyle(
                      fontSize: height * 0.065,

                    ),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //updatre button
                        IconButton(
                          icon: Icon(Icons.auto_fix_normal_sharp,
                          size: height * 0.076,
                          color: Colors.yellow,),
                          onPressed: () {
                            openNoteBox(docID);
                          },
                        ),
                        IconButton(onPressed: (){
                          createService.deleteNotes(docID);
                        }, icon: Icon(Icons.delete,
                          size: height*0.076,
                          color: Colors.red,))
                      ],
                    ),
                  );
                });
          } else {
            return const Text('Тэмдэглэл алга...');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNoteBox(null);
        },
        child: const Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
