import 'package:instagram_planner/profile/data/post_model.dart';

abstract class PostRepo {
  Future<String> addPost({
    required String uid,
    required String path,
    required String description,
  });
  Future<void> removePost({
    required String uid,
    required String index,
    required PostModel post,
  });
  Future<void> updatePost({required PostModel post, required String uid});
  Future<void> reorderPosts(List<PostModel> posts, String uid);
  Future<List<PostModel>> fetchPosts(String uid);
  Future<List<PostModel>> getAllPosts(String uid);
}
