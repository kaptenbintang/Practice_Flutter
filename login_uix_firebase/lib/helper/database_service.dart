// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:login_uix_firebase/constant/firebase_field_name.dart';
import 'package:login_uix_firebase/model/appointment_data.dart';
import 'package:login_uix_firebase/model/events/events_data.dart';
import 'package:login_uix_firebase/model/manage_practioner_data.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';
import 'package:login_uix_firebase/model/roles_data.dart';
import 'package:login_uix_firebase/model/serviceCategory_data.dart';
import 'package:login_uix_firebase/model/services_data.dart';
import 'package:login_uix_firebase/user_info/models/user_info_model.dart';

import '../model/clientType_data.dart';
import '../model/user_data.dart';

//Class contain all firestore api data manipulation function
class DataService {
  final _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUser(UserData employeeData) async {
    await _db.collection("users").add(employeeData.toMap());
  }

  addRoles(RolesData dataTestRole) async {
    await _db.collection("roles").add(dataTestRole.toMap());
  }

  addClientType(ClientData clientDataType) async {
    await _db.collection("clientType").add(clientDataType.toMap());
  }

  addServices(ServicesData servicesData) async {
    await _db.collection("services").add(servicesData.toMap());
  }

  addPractioners(PractionerData practionerData) async {
    await _db.collection("practioners").add(practionerData.toMap());
  }

  addEvent(EventsData eventsData) async {
    await _db.collection("events").add(eventsData.toMap());
  }

  addAppointment(AppointmentData appointmentData) async {
    await _db.collection("appointment").add(appointmentData.toMap());
  }

  addServicesCategory(serviceCategoryClass servicesDataCategory) async {
    await _db.collection("servicesCategory").add(servicesDataCategory.toMap());
  }

  addBlackout(String dayName, String uid) async {
    await _db.collection("practioners").where("uid", isEqualTo: uid).get();
    // .({'test': dayName});
  }

  static Future<void> updateUserI(UserData employeeData) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(employeeData.id)
        .update(employeeData.toMap());
  }

  Future<void> updateUser(UserData employeeData) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(employeeData.id)
        .update(employeeData.toMap());
  }

  Future<void> updateRoles(RolesData dataTestRole) async {
    await _db
        .collection("roles")
        .doc(dataTestRole.id)
        .update(dataTestRole.toMap());
  }

  Future<void> updateClientType(ClientData clientDataType) async {
    await _db
        .collection("clientType")
        .doc(clientDataType.id)
        .update(clientDataType.toMap());
  }

  Future<void> updateServices(ServicesData servicesData) async {
    await _db
        .collection("services")
        .doc(servicesData.id)
        .update(servicesData.toMap());
  }

  Future<void> updatePractioners(managePractionerData mngpractionerData) async {
    await _db
        .collection("practioners")
        .doc(mngpractionerData.id)
        .update(mngpractionerData.toMap());
  }

  Future<void> updateEvent(EventsData eventData) async {
    await _db.collection("events").doc(eventData.id).update(eventData.toMap());
  }

  Future<void> updateAppointment(AppointmentData appointmentData) async {
    await _db
        .collection("appointment")
        .doc(appointmentData.clientId)
        .update(appointmentData.toMap());
  }

  Future<void> updateServicesCategory(
      serviceCategoryClass servicesDataCategory) async {
    await _db
        .collection("servicesCategory")
        .doc(servicesDataCategory.id)
        .update(servicesDataCategory.toMap());
  }

  Future<void> deleteUser(BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("users").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Deleted Account"),
            );
          },
        );
      },
    );
  }

  Future<void> deleteRoles(BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("roles").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Deleted Roles"),
            );
          },
        );
      },
    );
  }

  Future<void> deleteClientType(BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("clientType").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Deleted Types"),
            );
          },
        );
      },
    );
  }

  Future<void> deleteServices(BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("services").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Deleted Services"),
            );
          },
        );
      },
    );
  }

  Future<void> deletePractioners(
      BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("practioners").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Practioner deleted"),
            );
          },
        );
      },
    );
  }

  Future<void> deleteEvent(BuildContext context, EventsData eventData) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("events").doc(eventData.id);

    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Event deleted"),
            );
          },
        );
      },
    );
  }

  deleteEventImage(EventsData eventData) async {
    if (eventData.eventsImage.toString() != '') {
      await _storage.refFromURL(eventData.eventsImage!).delete();
    }
  }

  deleteUserImage(UserInfoModel userData) async {
    if (userData.profilePic.toString() != '') {
      await _storage.refFromURL(userData.profilePic!).delete();
    }
  }

  Future<void> deleteAppointment(
      BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("appointment").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Appointment deleted"),
            );
          },
        );
      },
    );
  }

  Future<void> deleteServicesCategory(
      BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("servicesCategory").doc(documentId);
    await address.delete().then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Services Category deleted"),
            );
          },
        );
      },
    );
  }

  Future<void> markdeleteUser(BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("users").doc(documentId);
    await address.update({"markDeleted": true}).then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Account have been deleted"),
            );
          },
        );
      },
    ).onError((error, stackTrace) {
      print('Error BY: $error');
    });
  }

  Future<void> markdeleteRestoreUser(
      BuildContext context, String documentId) async {
    // await _db.collection("users").doc(documentId).delete();
    final address = _db.collection("users").doc(documentId);
    await address.update({"markDeleted": false}).then(
      (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Account have been restored"),
            );
          },
        );
      },
    );
  }

  Future<List<UserData>> retrieveAllStaff(String? roles) async {
    if (roles == 'superadmin') {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("users")
          .where('roles', isNotEqualTo: 'user')
          .get();
      return snapshot.docs
          .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
          .toList();
    } else {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("users")
          .where('roles', isNotEqualTo: 'user')
          .where('markDeleted', isEqualTo: false)
          .get();

      return snapshot.docs
          .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
          .toList();
    }

    // final ref = _db.collection("users").doc().withConverter(
    //       fromFirestore: UserData.fromFirestore,
    //       toFirestore: (UserData data, _) => data.toFireStore(),
    //     );
    // final docSnap = await ref.get();
    // return docSnap.data();
  }

  Future<List<UserData>> retrieveClientNotDeleted() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("users")
        .where("roles", isEqualTo: 'user')
        .where('markDeleted', isEqualTo: false)
        .get();
    return snapshot.docs
        .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<UserData>> retrieveClientAll() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("users").where("roles", isEqualTo: 'user').get();
    return snapshot.docs
        .map((docSnapshot) => UserData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<RolesData>> retrieveRoles() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("roles").get();
    return snapshot.docs
        .map((docSnapshot) => RolesData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<ClientData>> retrieveClientType() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("clientType").get();
    return snapshot.docs
        .map((docSnapshot) => ClientData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<serviceCategoryClass>> retrieveServiceCategory() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("servicesCategory").get();
    return snapshot.docs
        .map((docSnapshot) =>
            serviceCategoryClass.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<ServicesData>> retrieveServices() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("services").get();
    return snapshot.docs
        .map((docSnapshot) => ServicesData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<PractionerData>> retrievePractionerAll() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("practioners")
        // .where("displayMain", isEqualTo: true)
        .get();
    return snapshot.docs
        .map((docSnapshot) => PractionerData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<EventsData>> retrieveEventsAll() async {
    print("hai");
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("events").get();

    return snapshot.docs
        .map((docSnapshot) => EventsData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<AppointmentData>> retrieveApppointmentAll() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("appointment")
        // .where('clientId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    return snapshot.docs
        .map((docSnapshot) => AppointmentData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<AppointmentData>> retrieveApppointment() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("appointment")
        .where('clientId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('statusAppointment', isEqualTo: 'ongoing')
        .get();
    return snapshot.docs
        .map((docSnapshot) => AppointmentData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<AppointmentData>> retrieveApppointment2() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection("appointment")
        .where('clientId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('statusAppointment', isNotEqualTo: 'ongoing')
        .get();
    return snapshot.docs
        .map((docSnapshot) => AppointmentData.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<Map<String, dynamic>> currentUsers(uid) async {
    final snapshot = await _db
        .collection("users")
        .where(FirebaseFieldName.userId, isEqualTo: uid)
        .limit(1)
        .get();
    final cruser = snapshot.docs[0];
    // Map<String, dynamic> data = snapshot.data()!;
    return cruser.data();
  }

  Future<List<UserData>> searchUser(String name) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').where('firstName', isEqualTo: name).get();
    return snapshot.docs.map((e) => UserData.fromDocumentSnapshot(e)).toList();
  }

  // static Future<UserCredential> register(
  //   String email,
  //   String password,
  // ) async {
  //   FirebaseApp app = await Firebase.initializeApp(
  //       name: 'Secondary', options: Firebase.app().options);
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     // Do something with exception. This try/catch is here to make sure
  //     // that even if the user creation fails, app.delete() runs, if is not,
  //     // next time Firebase.initializeApp() will fail as the previous one was
  //     // not deleted.
  //   }

  //   await app.delete();
  //   return Future.sync(() => userCredential);
  // }
}
