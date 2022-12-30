import 'package:firestore_display_movie/constant/constant.dart';
import 'package:firestore_display_movie/firestore_class.dart';
import 'package:firestore_display_movie/form_add_data.dart';
import 'package:flutter/material.dart';

class FirestoreTest extends StatefulWidget {
  const FirestoreTest({super.key});

  @override
  State<FirestoreTest> createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("firestore test"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200.0,
                width: 348.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: primarySwatchColor[50],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "add data to cloud Firestore",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                primarySwatchColor[100]),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FormForAddData()));
                          },
                          child: const Text("add data"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200.0,
                width: 348.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: primarySwatchColor[100],
                ),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        _firestoreMethods.setDoc();
                      },
                      child: const Text(
                        'setDoc',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.updateDoc();
                          },
                          child: const Text(
                            'updateDoc',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.dataType();
                          },
                          child: const Text(
                            'dataType',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.customObject();
                          },
                          child: const Text(
                            'customObject',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.generateId();
                          },
                          child: const Text(
                            'generateId',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.updateField();
                          },
                          child: const Text(
                            'updateField',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.increment();
                          },
                          child: const Text(
                            'increment',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _firestoreMethods.createRunTrans();
                          },
                          child: const Text(
                            'transaction',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
