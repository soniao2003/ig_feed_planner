import 'package:cloud_firestore/cloud_firestore.dart';

class InspirationModel {
  final String id;
  final String caption;

  InspirationModel({
    this.id = '',
    required this.caption,
  });

  factory InspirationModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InspirationModel(
      id: doc.id,
      caption: data['caption'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'caption': caption,
    };
  }
}
