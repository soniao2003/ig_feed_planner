// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_planner/profile/data/post_model.dart';
// import 'package:instagram_planner/profile/presentation/post_provider.dart';

// class PostPage extends ConsumerStatefulWidget {
//   final PostModel post;
//   final String uid;
//   final int index;

//   PostPage({required this.post, required this.uid, required this.index});

//   @override
//   _PostPageState createState() => _PostPageState();
// }

// class _PostPageState extends ConsumerState<PostPage> {
//   late TextEditingController _descriptionController;

//   @override
//   void initState() {
//     super.initState();
//     _descriptionController =
//         TextEditingController(text: widget.post.description);
//   }

//   @override
//   void dispose() {
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final postProvider = ref.watch(postNotifierProvider(widget.uid));

//     return Scaffold(
//         backgroundColor: Color.fromARGB(255, 45, 44, 44),
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 45, 44, 44),
//           title: Text(
//             'Update Post',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _postImage(widget.post.image, context),
//               SizedBox(height: 7),
//               Text(
//                 'DESCRIPTION',
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               Container(
//                   height: 50,
//                   width: 600,
//                   child: TextFormField(
//                       controller: _descriptionController,
//                       maxLines: 3,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         //labelStyle: TextStyle(color: Colors.white)),
//                       ))),
//               Padding(
//                   padding: EdgeInsets.all(10),
//                   child: ElevatedButton(
//                     onPressed: () => _updateDescription(context),
//                     child: Text('Update Description'),
//                   )),
//             ],
//           ),
//         ));
//   }

//   Widget _postImage(dynamic imageData, BuildContext context) {
//     if (imageData is String) {
//       if (imageData.startsWith('data:image')) {

//       final base64String = imageData.split(',').last;

//       final bytes = base64Decode(base64String);
//       return Container(
//         //padding: EdgeInsets.all(10),
//         alignment: Alignment.topCenter,
//         height: 400,
//         width: 300,
//         child: Image.memory(bytes, fit: BoxFit.cover),
//       );
//     } else{
//       return Image.network(
//           imageData,
//           fit: BoxFit.cover,
//           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//             return Center(
//               child: Text('Image not available'),
//             );
//           },
//       );
// }
// } else if (imageData is Uint8List) {
//       return Container(
//         //padding: EdgeInsets.all(10),
//         alignment: Alignment.topCenter,
//         height: 400,
//         width: 300,
//         child: Image.memory(imageData,
//           fit: BoxFit.cover,
//         ),
//       );
//     } else {
//       return SizedBox(); // Return an empty SizedBox as a placeholder
//     }
//   }

//   void _updateDescription(BuildContext context) async {
//     final newDescription = _descriptionController.text;
//     final updatedPost = PostModel(
//       id: widget.post.id,
//       image: widget.post.image,
//       useruid: widget.post.useruid,
//       description: newDescription,
//       order: widget.post.order,
//     );

//     try {
//       await ref
//           .read(postNotifierProvider(widget.uid).notifier)
//           .updatePost(updatedPost, widget.uid, widget.index);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Description updated successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update description')),
//       );
//     }
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/natifications/presentation/notification_page.dart';
import 'package:instagram_planner/profile/data/post_model.dart';
import 'package:instagram_planner/profile/presentation/post_provider.dart';
import 'package:instagram_planner/providers.dart';

class PostPage extends ConsumerStatefulWidget {
  final PostModel post;
  final String uid;
  final int index;

  PostPage({required this.post, required this.uid, required this.index});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.post.description);
    print(widget.index);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = ref.watch(postNotifierProvider(widget.uid));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 44, 44),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 45, 44, 44),
        title: Text(
          'Update Post',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 150,
                width: 150,
                child: _postImage(widget.post.image, context)),
            Text(
              'DESCRIPTION',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 70,
              width: 400,
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 7, 102),
                ),
                onPressed: () => _updateDescription(context),
                child: Text(
                  'Update Description',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(1),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    print('Triggering removePost method');
                    ref
                        .read(postNotifierProvider(widget.uid).notifier)
                        .removePost(
                            widget.uid, widget.post, widget.index.toString());
                  },
                  child: Text('Delete', style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(1),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleNotificationScreen()),
                    );
                    print('schedule post triggered');
                  },
                  child: Text('Schedule post',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  Widget _postImage(dynamic imageData, BuildContext context) {
    if (imageData is String) {
      if (imageData.startsWith('data:image')) {
        final base64String = imageData.split(',').last;
        final bytes = base64Decode(base64String);
        return Container(
          alignment: Alignment.topCenter,
          height: 400,
          width: 300,
          child: Image.memory(bytes, fit: BoxFit.cover),
        );
      } else if (imageData.startsWith('/data')) {
        // Handle local file paths
        return _buildLocalImage(File(imageData), context);
      } else {
        return Image.network(
          imageData,
          fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Center(
              child: Text('Image not available'),
            );
          },
        );
      }
    } else if (imageData is Uint8List) {
      return Container(
        alignment: Alignment.topCenter,
        height: 400,
        width: 300,
        child: Image.memory(
          imageData,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox(); // Return an empty SizedBox as a placeholder
    }
  }

  void _updateDescription(BuildContext context) async {
    final newDescription = _descriptionController.text;
    final updatedPost = PostModel(
      id: widget.post.id,
      image: widget.post.image,
      useruid: widget.post.useruid,
      description: newDescription,
      order: widget.post.order,
    );

    try {
      await ref
          .read(postNotifierProvider(widget.uid).notifier)
          .updatePost(updatedPost, widget.uid, widget.index);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Description updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update description')),
      );
    }
  }

  Widget _buildLocalImage(File file, BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 400,
      width: 300,
      child: Image.file(
        file,
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
