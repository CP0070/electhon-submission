import 'package:firebase_database/firebase_database.dart';
import 'package:fitpad/features/dashboard/screens/output_screen.dart';
import 'package:fitpad/shared/utils/constants.dart';
import 'package:flutter/material.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({super.key});

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  List getData = [];
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  void initState() {
    _databaseReference
        .child('Leaderboard')
        .once()
        .then((DatabaseEvent databaseEvent) {
      setState(() {
        getData = databaseEvent.snapshot.value as List;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leaderboard',
          style: kTextStyleHeaders,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: getData.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: blueColor,
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Column(
                      children: [
                        Card(
                          elevation: 2,
                          color: Colors.white,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: const Image(
                              image: AssetImage('images/mainIcon.png'),
                              height: 40,
                              width: 40,
                            ),
                            title: Text('${getData[index]['AName']}',
                                style: kTextStyleLarge.copyWith(
                                    color: Colors.black)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OutputScreen(
                                        name: getData[index]['AName'],
                                        index: index),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: getData.length,
              ),
      ),
    );
  }
}
