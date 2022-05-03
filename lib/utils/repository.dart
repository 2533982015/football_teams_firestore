import 'package:cloud_firestore/cloud_firestore.dart';

class FootballRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('equipos');

  Future<List<QueryDocumentSnapshot<Object?>>> getTeams() async {
    final teams = await collection.get();
    return teams.docs.toList();
  }
}
