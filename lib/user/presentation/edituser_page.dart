import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/user_model.dart';
import 'package:instagram_planner/natifications/presentation/notification_page.dart';
import 'package:instagram_planner/profile/data/post_model.dart';
import 'package:instagram_planner/profile/presentation/post_provider.dart';
import 'package:instagram_planner/providers.dart';
import 'package:instagram_planner/user/data/UserService.dart';

class UserPage extends ConsumerStatefulWidget {
  final UserModel user;
  final String uid;

  UserPage({required this.uid, required this.user});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _nameController = TextEditingController(text: widget.user.name);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(userNotifierProvider(widget.uid));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 44, 44),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 45, 44, 44),
        title: Text(
          'Update Info',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //     height: 150,
            //     width: 150,
            //     child: _postImage(widget.user.avatar, context)),
            Text(
              'username',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 70,
              width: 400,
              child: TextFormField(
                controller: _usernameController,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text(
              'name',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 70,
              width: 400,
              child: TextFormField(
                controller: _nameController,
                maxLines: 3,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text(
              'bio',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 70,
              width: 400,
              child: TextFormField(
                controller: _bioController,
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
                onPressed: () => _updateUsername(context),
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _postImage(dynamic imageData, BuildContext context) {
  //   if (imageData is String) {
  //     if (imageData.startsWith('data:image')) {
  //       final base64String = imageData.split(',').last;
  //       final bytes = base64Decode(base64String);
  //       return Container(
  //         alignment: Alignment.topCenter,
  //         height: 400,
  //         width: 300,
  //         child: Image.memory(bytes, fit: BoxFit.cover),
  //       );
  //     } else if (imageData.startsWith('/data')) {
  //       // Handle local file paths
  //       return _buildLocalImage(File(imageData), context);
  //     } else {
  //       return Image.network(
  //         imageData,
  //         fit: BoxFit.cover,
  //         errorBuilder:
  //             (BuildContext context, Object exception, StackTrace? stackTrace) {
  //           return Center(
  //             child: Text('Image not available'),
  //           );
  //         },
  //       );
  //     }
  //   } else if (imageData is Uint8List) {
  //     return Container(
  //       alignment: Alignment.topCenter,
  //       height: 400,
  //       width: 300,
  //       child: Image.memory(
  //         imageData,
  //         fit: BoxFit.cover,
  //       ),
  //     );
  //   } else {
  //     return SizedBox(); // Return an empty SizedBox as a placeholder
  //   }
  // }

  void _updateUsername(BuildContext context) async {
    final newUsername = _usernameController.text;
    final newName = _nameController.text;
    final newBio = _bioController.text;
    final updatedUser = UserModel(
      username: newUsername,
      email: widget.user.email,
      name: newName,
      bio: newBio,
      //avatar: widget.user.avatar,
    );

    try {
      await ref
          .read(userNotifierProvider(widget.uid).notifier)
          .updateUser(updatedUser, widget.uid);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update username')),
      );
    }
  }

  // Widget _buildLocalImage(File file, BuildContext context) {
  //   return Container(
  //     alignment: Alignment.topCenter,
  //     height: 400,
  //     width: 300,
  //     child: Image.file(
  //       file,
  //       fit: BoxFit.cover,
  //       errorBuilder:
  //           (BuildContext context, Object exception, StackTrace? stackTrace) {
  //         return Center(
  //           child: Text('Image not available'),
  //         );
  //       },
  //     ),
  //   );
  // }
}
