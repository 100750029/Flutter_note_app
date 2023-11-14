import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note_model.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/note_input_background.jpeg'), // Replace with the path to your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(fontSize: 28),
              decoration: const InputDecoration(
                  border: InputBorder.none, 
                  hintText: "Title:",
                  hintStyle: TextStyle(color: Colors.black),
                ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: descriptionController,
              style: const TextStyle(
                fontSize: 18
                ),
              decoration: const InputDecoration(
                  border: InputBorder.none, 
                  hintText: "Description:",
                  hintStyle: TextStyle(color: Colors.black),
                ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
            // Show an error dialog if either title or description is empty
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('You must enter a title and description to save a note.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            return;
          }

          final note = Note(
            description: descriptionController.text,
            title: titleController.text,
          );

          widget.onNewNoteCreated(note);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
