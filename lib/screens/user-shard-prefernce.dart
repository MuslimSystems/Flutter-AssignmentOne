import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact {
  String name;
  String contact;
  Contact({required this.name, required this.contact});

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
      };
}

class PreferencesForm extends StatefulWidget {
  const PreferencesForm({Key? key}) : super(key: key);

  @override
  State<PreferencesForm> createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  late SharedPreferences usercontectform;

  getSharedPrefrences() async {
    usercontectform = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntousercontectform() {
    List<String> contactListString =
        contacts.map((contact) => jsonEncode(contact.toJson())).toList();
    usercontectform.setStringList('myData', contactListString);
  }

  readFromSp() {
    List<String>? contactListString = usercontectform.getStringList('myData');
    if (contactListString != null) {
      contacts = contactListString
          .map((contact) => Contact.fromJson(json.decode(contact)))
          .toList();
    }
  }

  @override
  void initState() {
    getSharedPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Contact Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts.add(Contact(name: name, contact: contact));
                        });
                        // Saving contacts list into Shared Prefrences
                        saveIntousercontectform();
                      }
                      //
                    },
                    child: const Text('Save')),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => getRow(index),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contact),
          ],
        ),
      ),
    );
  }
}
