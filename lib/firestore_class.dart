// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'custom_objects.dart';

class FirestoreMethods {
  var db = FirebaseFirestore.instance;
  // fonction 1
  void setDoc() {
    final city = <String, String>{
      "name": "Los angeles",
      "state": "CA",
      "country": "USA"
    };

    FirebaseFirestore.instance
        .collection("cities")
        .doc("LA")
        .set(city)
        .onError((e, _) => print("Error writing document: $e"));
  }

  //fonction 2
  void updateDoc() {
    // Update one field, creating the document if it does not already exist.
    final data = {"capital": true};

    FirebaseFirestore.instance
        .collection("cities")
        .doc("BJ")
        .set(data, SetOptions(merge: true));
  }

  //fonction 3
  void dataType() {
    final docData = {
      "stringExample": "Hello world!",
      "booleanExample": true,
      "numberExample": 3.14159265,
      "dateExample": Timestamp.now(),
      "listExample": [1, 2, 3],
      "anotherMap": {"c": 6, "d": false},
      "nullExample": null
    };

    final nestedData = {
      "a": 5,
      "b": true,
    };

    docData["objectExample"] = nestedData;

    FirebaseFirestore.instance
        .collection("data")
        .doc("one")
        .set(docData)
        .onError((e, _) => print("Error writing document: $e"));
  }

  //function 4
  void customObject() async {
    final city = City(
      name: "Los Angeles",
      state: "CA",
      country: "USA",
      capital: false,
      population: 5000000,
      regions: ["west_coast", "socal"],
    );
    final docRef = FirebaseFirestore.instance
        .collection("cities")
        .withConverter(
          fromFirestore: City.fromFirestore,
          toFirestore: (City city, options) => city.toFirestore(),
        )
        .doc("LA");
    await docRef.set(city);
  }

  // function 5
  void generateId() {
    // Add a new document with a generated id.
    final data = {"name": "Tokyo", "country": "Japan"};

    FirebaseFirestore.instance.collection("cities").add(data).then(
        (documentSnapshot) =>
            print("Added Data with ID: ${documentSnapshot.id}"));
  }

  //fonction 6
  void updateField() {
    final washingtonRef =
        FirebaseFirestore.instance.collection("cities").doc("LA");
    washingtonRef.update({"capital": true}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  //function 7
  void increment() {
    var washingtonRef =
        FirebaseFirestore.instance.collection('cities').doc('DC');

// Atomically increment the population of the city by 50.
    washingtonRef.update(
      {"population": FieldValue.increment(50)},
    );
  }

  //fonction 8
  void createRunTrans() {
    final sfDocRef = db.collection("cities").doc("SF");
    db.runTransaction((transaction) async {
      final snapshot = await transaction.get(sfDocRef);
      // Note: this could be done without a transaction
      //     by updating the population using FieldValue.increment()
      final newPopulation = snapshot.get("population") + 1;
      transaction.update(sfDocRef, {"population": newPopulation});
    }).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"),
    );
  }
}
