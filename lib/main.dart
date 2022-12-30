// ignore_for_file: avoid_print

import 'package:firestore_display_movie/add_movie_page.dart';
import 'package:firestore_display_movie/firebase_options.dart';
import 'package:firestore_display_movie/firestore_data.dart';
import 'package:firestore_display_movie/pages/auth_page.dart';
import 'package:firestore_display_movie/pages/information_personel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const AuthPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> body = [
    const MovieInformation(),
    const FirestoreTest(),
    InforamtionPersonnel(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: 'movie'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'movie'),
        ],
      ),
    );
  }
}

class MovieInformation extends StatefulWidget {
  const MovieInformation({super.key});

  @override
  State<MovieInformation> createState() => _MovieInformationState();
}

class _MovieInformationState extends State<MovieInformation> {
  final Stream<QuerySnapshot> _moviesStream =
      FirebaseFirestore.instance.collection('Movies').snapshots();

  void addLikes(String docID, int likes) {
    var newLikes = likes + 1;

    try {
      FirebaseFirestore.instance
          .collection('Movies')
          .doc(docID)
          .update({"likes": newLikes}).then((value) => print("donnée à jour"));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Movie App"),
        leading: IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const AddPage();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _moviesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading..."),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> movie =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: Image.network(movie['poster']),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            movie['Name'],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("année de production"),
                          Text(movie['year']),
                          Row(
                            children: [
                              for (final categorie in movie['categorie'])
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    backgroundColor: Colors.lightBlue,
                                    label: Text(categorie),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  addLikes(document.id, movie['likes']);
                                },
                                icon: const Icon(Icons.favorite),
                              ),
                              Text(movie['likes'].toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
