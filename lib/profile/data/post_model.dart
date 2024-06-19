import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  //final String title;
  final String image;
  final String useruid;
  final String description;
  final int order;

  PostModel({
    this.id = '',
    //required this.title,
    required this.image,
    required this.useruid,
    required this.description,
    this.order = 0, // Include in constructor
  });

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      image: data['image'],
      useruid: doc['useruid'],
      description: doc['description'],
      order: doc['order'] ?? 0, // Default to 0 if order is missing
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'useruid': useruid,
      'description': description,
      'order': order,
    };
  }

  PostModel copyWith({
    String? id,
    String? image,
    String? useruid,
    String? description,
    int? order,
  }) {
    return PostModel(
      id: id ?? this.id,
      image: image ?? this.image,
      useruid: useruid ?? this.useruid,
      description: description ?? this.description,
      order: order ?? this.order,
    );
  }
}
