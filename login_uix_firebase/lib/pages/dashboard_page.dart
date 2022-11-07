import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_uix_firebase/model/user_data.dart';

import '../helper/database_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DataService service = DataService();
  Future<List<UserData>>? userList;
  List<UserData>? retrievedUserList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    userList = service.retrieveUsers();
    retrievedUserList = await service.retrieveUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard Home'),
        ),
        body: FutureBuilder(
          future: userList,
          builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
            // if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: retrievedUserList!.length,
              itemBuilder: (context, index) {
                return _buildListUser(context, retrievedUserList![index]);
              },
            );
            // }
          },
        )
        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     RefreshIndicator(
        //       onRefresh: () async {},
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: FutureBuilder(
        //           future: userList,
        //           builder: (BuildContext context,
        //               AsyncSnapshot<List<UserData>> snapshot) {
        //             if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        //               return ListView.separated(
        //                   itemCount: retrievedUserList!.length,
        //                   separatorBuilder: (context, index) => const SizedBox(
        //                         height: 10,
        //                       ),
        //                   itemBuilder: (context, index) {
        //                     return Dismissible(
        //                       onDismissed: ((direction) async {
        //                         await service.deleteUser(
        //                             retrievedUserList![index].id.toString());
        //                         setState(() {
        //                           retrievedUserList!.removeAt(index);
        //                         });
        //                       }),
        //                       background: Container(
        //                         decoration: BoxDecoration(
        //                             color: Colors.red,
        //                             borderRadius: BorderRadius.circular(16.0)),
        //                         padding: const EdgeInsets.only(right: 28.0),
        //                         alignment: AlignmentDirectional.centerEnd,
        //                         child: const Text(
        //                           "DELETE",
        //                           style: TextStyle(color: Colors.white),
        //                         ),
        //                       ),
        //                       direction: DismissDirection.endToStart,
        //                       resizeDuration: const Duration(milliseconds: 200),
        //                       key: UniqueKey(),
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                             color: const Color.fromARGB(255, 83, 80, 80),
        //                             borderRadius: BorderRadius.circular(16.0)),
        //                         child: ListTile(
        //                           onTap: () {
        //                             Navigator.pushNamed(context, "/edit",
        //                                 arguments: retrievedUserList![index]);
        //                           },
        //                           shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(8.0),
        //                           ),
        //                           title:
        //                               Text(retrievedUserList![index].emailUser),
        //                           subtitle: Text(
        //                               "${retrievedUserList![index].firstName.toString()}, ${retrievedUserList![index].lastName.toString()}"),
        //                           trailing: const Icon(Icons.arrow_right_sharp),
        //                         ),
        //                       ),
        //                     );
        //                   });
        //             } else if (snapshot.connectionState == ConnectionState.done &&
        //                 retrievedUserList!.isEmpty) {
        //               return Center(
        //                 child: ListView(
        //                   children: const <Widget>[
        //                     Align(
        //                         alignment: AlignmentDirectional.center,
        //                         child: Text('No data available')),
        //                   ],
        //                 ),
        //               );
        //             } else {
        //               return const Center(child: CircularProgressIndicator());
        //             }
        //           },
        //         ),
        //       ),
        //     ),
        //     ElevatedButton(
        //       child: Text("Log out"),
        //       onPressed: () {
        //         FirebaseAuth.instance.signOut();
        //       },
        //     )
        //   ],
        // ),
        );
  }

  Widget _buildListUser(BuildContext context, UserData snapshot) {
    return Material(
      child: Center(
        child: ListTile(
          onTap: () {
            // Navigator.pushNamed(context, ArticlesDetailPage.routeName,
            //     arguments: article);
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          title: Text(snapshot.emailUser),
          subtitle: Text(snapshot.firstName),
        ),
      ),
    );
  }
}
