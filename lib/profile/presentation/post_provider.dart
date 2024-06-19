import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/profile/domain/post_repo.dart';
import '../data/post_model.dart';
import '../data/post_service.dart';

class PostNotifier extends StateNotifier<List<PostModel>> {
  late final PostRepo _postRepo;

  PostNotifier(StateNotifierProviderRef ref, uid) : super([]) {
    _postRepo = ref.read(postsProvider);
    fetchPosts(uid);
  }

  Future<void> fetchPosts(String uid) async {
    try {
      List<PostModel> fetchedPosts = await _postRepo.fetchPosts(uid);
      state = fetchedPosts;
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> addPost(PostModel post) async {
    //print('uid2${uid}');
    //print('path2${path}');
    print("PATH IN REPO: ${post.image}");
    String postId = await _postRepo.addPost(
        description: post.description, uid: post.useruid, path: post.image);
    //dodajemy do stanu post z id
    PostModel postWithId = post.copyWith(id: postId);
    state = [...state, postWithId];
  }

  // Future<void> removePost(String postId) async {
  //   await _postService.removePost(postId: postId);
  //   getAllPosts(); // Refresh posts after removal
  // }

  Future<void> removePost(String uid, PostModel post, String index) async {
    await _postRepo.removePost(uid: uid, index: index, post: post);
    print('post deleted provider');
    print(post.id);
    state = state.where((element) => element.id != post.id).toList();
  }

  // Future<void> updatePost(PostModel post, String uid, int index) async {
  //   await _postService.updatePost(post: post);
  //   getAllPosts(uid); // Refresh posts after updating
  // }

  Future<void> updatePost(PostModel post, String uid, int index) async {
    try {
      await _postRepo.updatePost(post: post, uid: uid);

      var updatedState = List<PostModel>.from(state);
      updatedState[index] = post;
      state = updatedState;
    } catch (e) {
      print('Error updating post: $e');
      throw e;
    }
  }

  Future<void> reorderPosts(int oldIndex, int newIndex, String uid) async {
    print(uid);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final postToMove = state.removeAt(oldIndex);
    state.insert(newIndex, postToMove);
    state = [...state];

    try {
      await _postRepo.reorderPosts(state, uid);
    } catch (e) {
      //wracamy do poprzedniej kolejności w przypadku błędu
      state.removeAt(newIndex);
      state.insert(oldIndex, postToMove);
      state = [...state];
      throw e;
    }
  }
}

// final postNotifierProvider =
//     StateNotifierProvider.family<PostNotifier, List<PostModel>, String>(
//         (ref, uid) {
//   return PostNotifier(ref, uid);
// });
