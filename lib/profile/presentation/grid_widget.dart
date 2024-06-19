import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/profile/presentation/post_provider.dart';
import 'package:instagram_planner/profile/presentation/single_post_page.dart';
import 'package:instagram_planner/providers.dart';
import '../data/post_model.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class GridPostsState extends ConsumerWidget {
  final String uid;

  GridPostsState({required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('grid read');

    // Patrzymy na zmiany w post list
    final postList = ref.watch(postNotifierProvider(uid));

    return postList != null
        ? ReorderableGridView.count(
            shrinkWrap: true,
            //Grid nie przewija się i zajmuje tylko tyle miejsca, ile potrzeba do wyświetlenia jej elementów.
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            //przekształcamy listę postList na mapę, gdzie kluczem jest indeks elementu na liście, a wartością jest sam element
            children: postList.asMap().entries.map((entry) {
              int index = entry.key;
              PostModel item = entry.value;
              return Container(
                key: ValueKey(item.id),
                child: Card(
                  elevation: 2.0,
                  child: _buildImageWidget(item.image, context, item, index),
                ),
              );
            }).toList(),
            onReorder: (int oldIndex, int newIndex) {
              ref
                  .read(postNotifierProvider(uid).notifier)
                  .reorderPosts(oldIndex, newIndex, uid);
            },
          )
        : CircularProgressIndicator(); // Kiedy postList jest nullem/ ładuje się to pokazuje sie kółko ładowania
  }

//zwracanie obrazów w zależności od ich typu
  Widget _buildImageWidget(
      dynamic imageData, BuildContext context, PostModel post, int index) {
    if (imageData is String) {
      if (imageData.startsWith('data:image')) {
        //base64 image
        final base64String = imageData.split(',').last;
        final bytes = base64Decode(base64String);
        return _buildMemoryImage(bytes, context, post, index);
      } else {
        //URL
        if (imageData.startsWith('/data')) {
          //lokalne pliki
          return _buildLocalImage(File(imageData), context, post, index);
        } else {
          return GestureDetector(
            onDoubleTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostPage(
                    post: post,
                    uid: uid,
                    index: index,
                  ),
                ),
              );
            },
            child: Image.network(
              imageData,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Center(
                  child: Text('Image not available'),
                );
              },
            ),
          );
        }
      }
    } else if (imageData is Uint8List) {
      // pliki z pamieci
      return _buildMemoryImage(imageData, context, post, index);
    } else if (imageData is File) {
      // lokalne pliki
      return _buildLocalImage(imageData, context, post, index);
    } else {
      return SizedBox();
    }
  }

//wyświetla obraz z pamięci (Uint8List)
  Widget _buildMemoryImage(
      Uint8List bytes, BuildContext context, PostModel post, int index) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(
              post: post,
              uid: uid,
              index: index,
            ),
          ),
        );
      },
      child: Image.memory(
        bytes,
        fit: BoxFit.cover,
      ),
    );
  }

//wyświetla obraz z lokalnego pliku (File)
  Widget _buildLocalImage(
      File file, BuildContext context, PostModel post, int index) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(
              post: post,
              uid: uid,
              index: index,
            ),
          ),
        );
      },
      child: Image.file(
        file, // Directly pass the File object here
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Center(
            child: Text('Image not available'),
          );
        },
      ),
    );
  }
}
