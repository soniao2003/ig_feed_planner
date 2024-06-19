// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
// import 'package:instagram_planner/authentification/data/auth_service.dart';
// import 'package:instagram_planner/main.dart';
// import 'dart:io';

// import 'dart:html' as html;

// final selectedImageUrlProvider = StateProvider<String?>((ref) => null);

// class CreateAccount extends ConsumerWidget {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final auth = ref.read(authProvider.notifier);
//     final selectedImageUrl = ref.watch(selectedImageUrlProvider);

//     void _getImage() {
//       final uploadInput = html.FileUploadInputElement();
//       uploadInput.accept = 'image/*'; // Accept only image files
//       uploadInput.click();

//       uploadInput.onChange.listen((event) {
//         final file = uploadInput.files!.first;
//         final reader = html.FileReader();

//         reader.onLoadEnd.listen((loadEndEvent) {
//           final imageData = reader.result as String?;
//           ref.read(selectedImageUrlProvider.notifier).state = imageData;
//         });

//         reader.readAsDataUrl(file); // Read file as data URL
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Account'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 255, 7, 102),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (selectedImageUrl != null && selectedImageUrl.isNotEmpty)
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(selectedImageUrl),
//               )
//             else
//               const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getImage,
//               child: const Text('Upload Picture'),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(hintText: 'Username'),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 2,
//               child: TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   hintText: 'Password',
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 print(
//                     'Email: ${_emailController.text}, Password: ${_passwordController.text}, avatar${selectedImageUrl}');
//                 auth.register(
//                   _usernameController.text,
//                   _emailController.text,
//                   _passwordController.text,
//                   selectedImageUrl ??
//                       'assets/images/avatar.jpg', // Default image path
//                 );
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         const MyHomePage(title: 'Instagram planner page'),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Create Account',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
import 'package:instagram_planner/authentification/data/auth_service.dart';
import 'package:instagram_planner/main.dart';
import 'dart:io';

import 'package:instagram_planner/providers.dart';

//final selectedImageUrlProvider = StateProvider<String?>((ref) => null);

class CreateAccount extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  //final picker = ImagePicker();

  // Future<void> _getImage(WidgetRef ref) async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     ref.read(selectedImageUrlProvider.notifier).state = pickedFile.path;
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);
    //final selectedImageUrl = ref.watch(selectedImageUrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 7, 102),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if (selectedImageUrl != null && selectedImageUrl.isNotEmpty)
            //   CircleAvatar(
            //     radius: 50,
            //     backgroundImage: FileImage(File(selectedImageUrl)),
            //   )
            // else
            //   const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => _getImage(ref),
            //   child: const Text('Upload Picture'),
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _bioController,
                decoration: const InputDecoration(hintText: 'Bio'),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                print(
                    'Email: ${_emailController.text}, Password: ${_passwordController.text}');
                auth.register(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _nameController.text,
                  _bioController.text,
                  // selectedImageUrl ??
                  //     'assets/images/avatar.jpg', // Default image path
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Instagram planner page'),
                  ),
                );
              },
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}
