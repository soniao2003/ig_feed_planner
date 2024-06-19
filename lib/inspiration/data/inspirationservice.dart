import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/inspiration/data/inspiration_model.dart';
import 'package:instagram_planner/inspiration/domain/inspiration_repo.dart';

class InspirationService extends InspirationRepo {
  late List<InspirationModel> postList;
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('inspirations');

  @override
  Future<List<InspirationModel>> fetchInspirations(String category) async {
    QuerySnapshot querySnapshot =
        await _postsCollection.doc(category).collection('captions').get();
    List<InspirationModel> posts = querySnapshot.docs.map((doc) {
      return InspirationModel(
        id: doc.id,
        caption: doc['caption'],
      );
    }).toList();
    print('inspo service works');
    return posts;
  }
}

final inspirationsProvider = Provider<InspirationService>((ref) {
  return InspirationService();
});
