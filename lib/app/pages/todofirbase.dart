import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoFirbase extends StatefulWidget {
  const TodoFirbase({super.key});

  @override
  State<TodoFirbase> createState() => _TodoFirbaseState();
}

class _TodoFirbaseState extends State<TodoFirbase> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('task');

  final TextEditingController taskNameController = TextEditingController();
  void addDataToFirestore() async {
    try {
      // Get a reference to the collection
      CollectionReference task = _firestore.collection('task');

      // Add a document with a generated ID
      await task.add({
        'taskName': taskNameController.text,
      });
      taskNameController.clear();
      print('Data added to Firestore successfully!');
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  void deleteTask(String taskId) async {
    try {
      await tasks.doc(taskId).delete();
      print('Task deleted from Firestore successfully!');
    } catch (e) {
      print('Error deleting task from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(CupertinoIcons.calendar),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Todo List Firbase")),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14),
                  controller: taskNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Task',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    addDataToFirestore();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Save'),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: tasks.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var taskData = snapshot.data!.docs[index];
                        return ListTile(
                          title: Text(taskData['taskName']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              deleteTask(taskData.id);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
