import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/profile/domain/post_repo.dart';
import 'post_model.dart';

class PostService extends PostRepo {
  late List<PostModel> postList;
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  // @override
  // Future<List<PostModel>> getAllPosts({required String uid}) async {
  //   try {
  //     // Pobiernie wszystkich postów z kolekcji 'posts' dla danego użytkownika
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc(uid)
  //         .collection('userposts')
  //         .orderBy('order')
  //         .get();

  //     // Tworzenie listy postów na podstawie dokumentów zwróconych przez zapytanie
  //     List<PostModel> postList =
  //         querySnapshot.docs.map((doc) => PostModel.fromDocument(doc)).toList();

  //     return postList;
  //   } catch (e) {
  //     print('Error fetching posts: $e');
  //     throw e;
  //   }
  // }

  @override
  Future<String> addPost({
    required String uid,
    required String path,
    required String description,
  }) async {
    try {
      // Pobranie ostatniego posta, aby ustalić kolejność nowego posta
      QuerySnapshot querySnapshot = await _postsCollection
          .doc(uid)
          .collection('userposts')
          .orderBy('order', descending: true)
          .limit(1)
          .get();

      //Jeśli nie ma żadnych postów, ustal kolejność nowego posta na 1
      int nextOrder = querySnapshot.docs.isEmpty
          ? 1
          : querySnapshot.docs.first['order'] + 1;

      // Dodanie nowego posta do kolekcji 'userposts' dla danego użytkownika
      DocumentReference docRef =
          await _postsCollection.doc(uid).collection('userposts').add({
        'image': path,
        'description': description,
        'order': nextOrder,
        'useruid': uid,
      });
      //zwracamy id zeby state w provider mial id posta i mogl przekazac do reorderPosts
      return docRef.id;
    } catch (e) {
      print('Error adding post: $e');
      throw e;
    }
  }

  @override
  Future<void> removePost({
    required String uid,
    required String index,
    required PostModel post,
  }) async {
    await _postsCollection
        .doc(uid)
        .collection('userposts')
        .doc(post.id)
        .delete();
  }

  @override
  Future<void> updatePost(
      {required PostModel post, required String uid}) async {
    await _postsCollection
        .doc(uid)
        .collection('userposts')
        .doc(post.id)
        .update(post.toMap());
  }

  @override
  Future<void> reorderPosts(List<PostModel> posts, String uid) async {
    //mozemy zrobic wiele róznych operacji
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {
      for (int i = 0; i < posts.length; i++) {
        print('Post ${i} id: ${posts[i].id}');
        DocumentReference docRef =
            _postsCollection.doc(uid).collection('userposts').doc(posts[i].id);

        batch.update(docRef, {'order': i});
      }

      await batch.commit();
      print('Posts reordered successfully!');
    } catch (e) {
      print('Error reordering posts: $e');
      throw e;
    }
  }

  @override
  Future<List<PostModel>> fetchPosts(String uid) async {
    QuerySnapshot querySnapshot =
        await _postsCollection.doc(uid).collection('userposts').get();
    List<PostModel> posts = querySnapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        image: doc['image'],
        useruid: doc['useruid'],
        description: doc['description'],
        order: doc['order'] ?? 0,
      );
    }).toList();
    return posts;
  }

  @override
  Future<List<PostModel>> getAllPosts(String uid) async {
    try {
      QuerySnapshot querySnapshot =
          await _postsCollection.doc(uid).collection('userposts').get();
      List<PostModel> posts = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String image =
            data.containsKey('image') ? data['image'] : 'default_image_path';
        String useruid = data['useruid'];
        String description = data['description'];
        int order = data['order'] ?? 0;

        // Print out the data
        print('Image: $image');
        print('User UID: $useruid');
        print('Description: $description');
        print('Order: $order');

        return PostModel(
          id: doc.id,
          image: image,
          useruid: useruid,
          description: description,
          order: order,
        );
      }).toList();
      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      throw e;
    }
  }
}

final postsProvider = Provider<PostService>((ref) {
  return PostService();
});
