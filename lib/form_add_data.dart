import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormForAddData extends StatefulWidget {
  const FormForAddData({super.key});

  @override
  State<FormForAddData> createState() => _FormForAddDataState();
}

class _FormForAddDataState extends State<FormForAddData> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  void addDataToFirestore() {
    final city = <String, String>{
      "name": _nameController.text,
      "state": _quantityController.text,
    };
    FirebaseFirestore.instance.collection('shopping_list').add(city);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
            ),
            TextField(
              controller: _quantityController,
            ),
            ElevatedButton(
              onPressed: () {
                addDataToFirestore();
              },
              child: const Text("add"),
            ),
          ],
        ),
      ),
    );
  }
}
