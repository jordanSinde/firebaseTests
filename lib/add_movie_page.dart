import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect/multiselect.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _posterController = TextEditingController();
  List<String> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "add a movie",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AddMovieField(fieldName: "Nom: ", unController: _nameController),
              const SizedBox(
                height: 20,
              ),
              AddMovieField(
                  fieldName: "Année: ", unController: _yearController),
              const SizedBox(
                height: 20,
              ),
              AddMovieField(
                  fieldName: "image: ", unController: _posterController),
              const SizedBox(
                height: 20,
              ),
              DropDownMultiSelect(
                onChanged: (List<String> x) {
                  setState(() {
                    categories = x;
                  });
                },
                options: const [
                  "Action",
                  "Science-Fiction",
                  "Aventure",
                  "Comedie"
                ],
                selectedValues: categories,
                whenEmpty: 'Categories',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50.0)),
                onPressed: () {
                  FirebaseFirestore.instance.collection("Movies").add({
                    "Name": _nameController.value.text,
                    "year": _yearController.value.text,
                    "poster": _posterController.value.text,
                    "categorie": categories,
                    "likes": 0,
                  });
                  Navigator.pop(context);
                },
                child: const Text("ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMovieField extends StatelessWidget {
  const AddMovieField({
    Key? key,
    required this.fieldName,
    required this.unController,
  }) : super(key: key);

  final String? fieldName;
  final TextEditingController unController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(
          color: Colors.white30,
          width: 1.5,
        ),
      ),
      title: Row(
        children: [
          Text(fieldName!),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: unController,
            ),
          ),
        ],
      ),
    );
  }
}
