import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:football_teams_firestore/utils/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Football Teams',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage());
}

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Teams'),
      ),
      body: StreamBuilder(
        stream: FootballRepository().collection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        child: ListTile(
                          leading: Image.network(documentSnapshot['foto']),
                          title: Text(documentSnapshot['nombre']),
                          subtitle: Text('${documentSnapshot['entrenador']}'),
                          trailing: Text(
                              'Estadio: ${documentSnapshot['estadio']['nombre']}'),
                        ),
                      ));
                });
          }
          
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
