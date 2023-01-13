import 'package:cloud_firestore/cloud_firestore.dart';

class RolesData {
  final String? id;
  final String? rolesName;
  final bool? canWrite;
  final bool? canWriteAll;
  final bool? canRead;
  final bool? canDelete;

  RolesData({
    this.id,
    this.rolesName,
    this.canWrite,
    this.canWriteAll,
    this.canRead,
    this.canDelete,
  });

  Map<String, dynamic> toMap() {
    return {
      "rolesName": rolesName,
      "canWrite": canWrite,
      "canWriteAll": canWriteAll,
      "canRead": canRead,
      "canDelete": canDelete,
    };
  }

  RolesData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        rolesName = doc.data()!["rolesName"],
        canWrite = doc.data()!["canWrite"],
        canWriteAll = doc.data()!["canWriteAll"],
        canRead = doc.data()!["canRead"],
        canDelete = doc.data()!["canDelete"];
}
