import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_uix_firebase/constant/firebase_collection_name.dart';
import 'package:login_uix_firebase/model/practioner_data.dart';

import 'package:login_uix_firebase/model/practioner_models/practioner_key.dart';
import 'package:login_uix_firebase/model/typedefs/is_loading.dart';

//update current practioner data in firestore

class EditPractionerNotifier extends StateNotifier<IsLoading> {
  EditPractionerNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> editPractioner({
    required PractionerData practioner,
  }) async {
    try {
      isLoading = true;

      final practionerInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.practioners,
          )
          .where(
            PractionerKey.userId,
            isEqualTo: practioner.id.toString(),
          )
          .limit(1)
          .get();
      if (practionerInfo.docs.isNotEmpty) {
        await practionerInfo.docs.first.reference.update(
          {
            PractionerKey.firstName: practioner.firstName,
            PractionerKey.lastName: practioner.lastName,
            PractionerKey.myApproach: practioner.myApproach,
            PractionerKey.myBackground: practioner.myBackground,
            PractionerKey.myQualifications: practioner.myQualifications,
            PractionerKey.mySpecialty: practioner.mySpecialty,
            PractionerKey.myRoles: practioner.myRoles,
            PractionerKey.languages: practioner.languages,
            PractionerKey.titleMain: practioner.titleMain,
          },
        );
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
