// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
// import 'package:instagram_planner/profile/presentation/post_provider.dart';
// import 'menu_page.dart';
// import 'grid_widget.dart';
// import 'profile_pict.dart';
// import '../data/post_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_planner/authentification/data/auth_service.dart';

// import 'bio_profile.dart';
// import 'profile_number.dart';
// import 'story_widget.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';
// import 'package:reorderable_grid_view/reorderable_grid_view.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:html' as html;

// // class ProfilePage extends StatefulWidget {
// //   const ProfilePage({super.key});

// //   @override
// //   State<ProfilePage> createState() => _ProfilPage();
// // }

// class ProfilePage extends ConsumerWidget {
//   //String userData = 'Loading...';

//   //int _currentIndex = 4;

//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     _currentIndex = index;
//   //   });
//   // }
//   final List<PostModel> postModel = [];

//   final picker = ImagePicker();
//   var currentUser = FirebaseAuth.instance.currentUser;
//   final selectedImageUrlProvider = StateProvider<String?>((ref) => null);

//   // Future<void> pickImage() async {
//   //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   //   if (pickedFile != null) {
//   //     //setState(() {
//   //     dataModel.add(DataModel(
//   //       id: dataModel.length,
//   //       image: pickedFile.path,
//   //     ));
//   //     //});
//   //   }
//   // }
//   Future<void> pickImage(WidgetRef ref) async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null && currentUser != null && currentUser!.uid != null) {
//       final newPost = PostModel(
//           id: '',
//           image: pickedFile.path,
//           useruid: currentUser!.uid,
//           description: "",
//           order: 0);
//       // print(newPost);
//       // print(currentUser!.uid);
//       // print('uid1${currentUser!.uid}');
//       // print('path1${pickedFile.path}');
//       await ref
//           .read(postNotifierProvider(currentUser!.uid).notifier)
//           .addPost(currentUser!.uid, pickedFile.path, "");
//     }
//   }

//   Future<void> getImage(WidgetRef ref) async {
//     if (kIsWeb) {
//       // Web platform
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
//     } else {
//       // Mobile platform
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null &&
//           currentUser != null &&
//           currentUser!.uid != null) {
//         final newPost = PostModel(
//             id: '',
//             image: pickedFile.path,
//             useruid: currentUser!.uid,
//             description: "",
//             order: 0);
//         await ref
//             .read(postNotifierProvider(currentUser!.uid).notifier)
//             .addPost(currentUser!.uid, pickedFile.path, "");
//       }
//     }
//   }

//   // Future<void> fetchUserData() async {
//   //   try {
//   //     final name = await AuthService().getUser(currentUser?.uid);
//   //     setState(() {
//   //       userData = name ?? 'User';
//   //     });
//   //   } catch (e) {
//   //     setState(() {
//   //       userData = 'Error: $e';
//   //     });
//   //   }
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   fetchUserData();
//   //   if (currentUser != null) {
//   //     print(currentUser?.uid);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedImageUrl = ref.watch(selectedImageUrlProvider);
//     final authState = ref.watch(authProvider);

//     print('data3${selectedImageUrl}');

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//           backgroundColor: Colors.black,
//           body: SafeArea(
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         // GestureDetector(
//                         //   onTap: () {
//                         //     showModalBottomSheet(
//                         //       isScrollControlled: true,
//                         //       context: context,
//                         //       builder: (BuildContext context) {
//                         //         return const Column(
//                         //           mainAxisSize: MainAxisSize.min,
//                         //           children: [
//                         //             BottomSheetContent(),
//                         //           ],
//                         //         );
//                         //       },
//                         //     );
//                         //   },
//                         child: Row(
//                           children: [
//                             StreamBuilder(
//                               stream: FirebaseFirestore.instance
//                                   .collection('users')
//                                   .doc(currentUser?.uid)
//                                   .snapshots(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return CircularProgressIndicator();
//                                 } else if (snapshot.hasError) {
//                                   return Text('Error');
//                                 } else if (snapshot.hasData &&
//                                     snapshot.data?.data() != null) {
//                                   var userDocument = snapshot.data!.data()
//                                       as Map<String, dynamic>;
//                                   return Text(
//                                     userDocument["username"],
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   );
//                                 } else {
//                                   return Text(
//                                     'No Data',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                             const SizedBox(width: 5),
//                             Image.asset(
//                               'assets/icons/arrow_down.png',
//                               color: Colors.white,
//                               height: 12,
//                               width: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             child: Image.asset(
//                               'assets/icons/threads.png',
//                               height: 23,
//                               width: 23,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 30),
//                           Container(
//                             //GestureDetector(
//                             // onTap: () {
//                             //   showModalBottomSheet(
//                             //       context: context,
//                             //       builder: (BuildContext context) {
//                             //         return Container(
//                             //           width: MediaQuery.of(context).size.width,
//                             //           decoration: const BoxDecoration(
//                             //               borderRadius: BorderRadius.only(
//                             //                 topLeft: Radius.circular(24),
//                             //                 topRight: Radius.circular(24),
//                             //               ),
//                             //               color: Color.fromARGB(237, 61, 60, 60)),
//                             //           child: const CreateWidget(),
//                             //         );
//                             //       });
//                             // },
//                             child: Image.asset(
//                               'assets/icons/more.png',
//                               height: 23,
//                               width: 23,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(width: 30),
//                           GestureDetector(
//                             //Container(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const MenuPage()),
//                               );
//                             },
//                             child: Image.asset(
//                               'assets/icons/menu.png',
//                               height: 23,
//                               width: 23,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 35),
//                 const Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ProfilePic(),
//                     ProfileNumber(
//                       amount: '50',
//                       name: 'posts',
//                     ),
//                     ProfileNumber(
//                       amount: '302',
//                       name: 'followers',
//                     ),
//                     ProfileNumber(
//                       amount: '301',
//                       name: 'following',
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 const BioProfile(),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //GestureDetector(
//                       // onTap: () {
//                       //   Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //           builder: (context) => const EditProfilePage()));
//                       // },
//                       //child: Container(
//                       Container(
//                         height: 35,
//                         width: 150,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(106, 158, 158, 158),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Center(
//                           child: Text(
//                             'Edit profile',
//                             style: TextStyle(color: Colors.white, fontSize: 17),
//                           ),
//                         ),
//                       ),
//                       //),
//                       //GestureDetector(
//                       // onTap: () {
//                       //   Navigator.push(
//                       //       context,
//                       //       MaterialPageRoute(
//                       //           builder: (context) => const ShareProfile()));
//                       // },
//                       // child: Container(
//                       Container(
//                         height: 35,
//                         width: 170,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(106, 158, 158, 158),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Center(
//                           child: Text(
//                             'Share profile',
//                             style: TextStyle(color: Colors.white, fontSize: 17),
//                           ),
//                         ),
//                       ),
//                       //),
//                       Container(
//                         height: 35,
//                         width: 45,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(106, 158, 158, 158),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Center(
//                             child: ImageIcon(
//                           AssetImage('assets/icons/invite.png'),
//                           size: 17,
//                           color: Colors.white,
//                         )),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Story(
//                         image: '123',
//                         title: 'Lombok',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '124',
//                         title: 'Bali',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '5',
//                         title: 'Jakarta',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '126',
//                         title: 'Afrika',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '127',
//                         title: 'Japan',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '100',
//                         title: 'Saudi Arabia',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '129',
//                         title: 'Turki',
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: TabBar(
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     unselectedLabelColor: Colors.grey,
//                     labelColor: Colors.white,
//                     indicatorColor: Colors.white,
//                     dividerColor: Color.fromARGB(80, 158, 158, 158),
//                     tabs: [
//                       ImageIcon(AssetImage('assets/icons/grid2.png')),
//                       ImageIcon(
//                         AssetImage('assets/icons/reels.png'),
//                       ),
//                       ImageIcon(AssetImage('assets/icons/tag.png')),
//                     ],
//                   ),
//                 ),
//                 GridPostsState(uid: currentUser!.uid),
//                 // GridView.builder(
//                 //     shrinkWrap: true,
//                 //     physics: const NeverScrollableScrollPhysics(),
//                 //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 //         crossAxisCount: 3,
//                 //         mainAxisSpacing: 1,
//                 //         crossAxisSpacing: 1),
//                 //     itemCount: 50,
//                 //     itemBuilder: (context, index) => Image.network(
//                 //         'https://picsum.photos/id/${152 + index}/500/500'))
//               ],
//             ),
//           ),
//           bottomNavigationBar: Container(
//               child: Row(children: [
//             Spacer(),
//             // FloatingActionButton(
//             //   onPressed: () async {
//             //     // Call getImage to choose an image
//             //     await getImage();
//             //     //await _imageSelectedCompleter.future;
//             //     print('data5${selectedImageUrl}');

//             //     // Check if an image is selected
//             //     if (selectedImageUrl != null && selectedImageUrl.isNotEmpty) {
//             //       // Add the post if an image is selected
//             //       final newPost = PostModel(
//             //           id: '',
//             //           image: selectedImageUrl,
//             //           useruid: currentUser!.uid,
//             //           description: "",
//             //           order: 0);

//             //       // Add the post using postNotifierProvider
//             //       await ref
//             //           .read(postNotifierProvider(currentUser!.uid).notifier)
//             //           .addPost("", currentUser!.uid, selectedImageUrl);

//             //       ref.read(selectedImageUrlProvider.notifier).state = null;

//             //       // Print a message indicating that the post has been added
//             //       print('Post added successfully.');
//             //     } else {
//             //       // Handle the case where no image is selected
//             //       print('No image selected.');
//             //     }
//             //   },
//             //   child: Icon(Icons.add),
//             // ),
//             ElevatedButton(
//               onPressed: () => getImage(ref),
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (selectedImageUrl != null && selectedImageUrl.isNotEmpty) {
//                   await ref
//                       .read(postNotifierProvider(currentUser!.uid).notifier)
//                       .addPost("", currentUser!.uid, selectedImageUrl);

//                   ref.read(selectedImageUrlProvider.notifier).state = null;

//                   print('Post added successfully.');
//                 } else {
//                   print('No image selected.');
//                 }
//               },
//               child: Text('Add Post'),
//             ),

//             Spacer()
//           ]))),
//     );
//   }
// }

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
// import 'package:instagram_planner/profile/presentation/post_provider.dart';
// import 'menu_page.dart';
// import 'grid_widget.dart';
// import 'profile_pict.dart';
// import '../data/post_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_planner/authentification/data/auth_service.dart';
// import 'bio_profile.dart';
// import 'profile_number.dart';
// import 'story_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:reorderable_grid_view/reorderable_grid_view.dart';

// class ProfilePage extends ConsumerWidget {
//   final List<PostModel> postModel = [];
//   final picker = ImagePicker();
//   var currentUser = FirebaseAuth.instance.currentUser;
//   final selectedImageUrlProvider = StateProvider<String?>((ref) => null);

//   Future<void> getImage(WidgetRef ref) async {
//     // Mobile platform
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null && currentUser != null && currentUser!.uid != null) {
//       final newPost = PostModel(
//           id: '',
//           image: pickedFile.path,
//           useruid: currentUser!.uid,
//           description: "",
//           order: 0);
//       await ref
//           .read(postNotifierProvider(currentUser!.uid).notifier)
//           .addPost(currentUser!.uid, pickedFile.path, "");
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedImageUrl = ref.watch(selectedImageUrlProvider);
//     final authState = ref.watch(authProvider);

//     print('data3${selectedImageUrl}');

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//           backgroundColor: Colors.black,
//           body: SafeArea(
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           StreamBuilder(
//                             stream: FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc(currentUser?.uid)
//                                 .snapshots(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Error');
//                               } else if (snapshot.hasData &&
//                                   snapshot.data?.data() != null) {
//                                 var userDocument = snapshot.data!.data()
//                                     as Map<String, dynamic>;
//                                 return Text(
//                                   userDocument["username"],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 );
//                               } else {
//                                 return Text(
//                                   'No Data',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                           const SizedBox(width: 5),
//                           Image.asset(
//                             'assets/icons/arrow_down.png',
//                             color: Colors.white,
//                             height: 12,
//                             width: 12,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/icons/threads.png',
//                             height: 23,
//                             width: 23,
//                             color: Colors.white,
//                           ),
//                           const SizedBox(width: 30),
//                           Image.asset(
//                             'assets/icons/more.png',
//                             height: 23,
//                             width: 23,
//                             color: Colors.white,
//                           ),
//                           const SizedBox(width: 30),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const MenuPage()),
//                               );
//                             },
//                             child: Image.asset(
//                               'assets/icons/menu.png',
//                               height: 23,
//                               width: 23,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 35),
//                 const Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ProfilePic(),
//                     ProfileNumber(
//                       amount: '50',
//                       name: 'posts',
//                     ),
//                     ProfileNumber(
//                       amount: '302',
//                       name: 'followers',
//                     ),
//                     ProfileNumber(
//                       amount: '301',
//                       name: 'following',
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 const BioProfile(),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         height: 35,
//                         width: 150,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(106, 158, 158, 158),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Center(
//                           child: Text(
//                             'Edit profile',
//                             style: TextStyle(color: Colors.white, fontSize: 17),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 35,
//                         width: 170,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(106, 158, 158, 158),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Center(
//                           child: Text(
//                             'Share profile',
//                             style: TextStyle(color: Colors.white, fontSize: 17),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 35,
//                         width: 45,
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(106, 158, 158, 158),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: const Center(
//                           child: ImageIcon(
//                             AssetImage('assets/icons/invite.png'),
//                             size: 17,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Story(
//                         image: '123',
//                         title: 'Lombok',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '124',
//                         title: 'Bali',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '5',
//                         title: 'Jakarta',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '126',
//                         title: 'Afrika',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '127',
//                         title: 'Japan',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '100',
//                         title: 'Saudi Arabia',
//                       ),
//                       SizedBox(width: 15),
//                       Story(
//                         image: '129',
//                         title: 'Turki',
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: TabBar(
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     unselectedLabelColor: Colors.grey,
//                     labelColor: Colors.white,
//                     indicatorColor: Colors.white,
//                     dividerColor: Color.fromARGB(80, 158, 158, 158),
//                     tabs: [
//                       ImageIcon(AssetImage('assets/icons/grid2.png')),
//                       ImageIcon(
//                         AssetImage('assets/icons/reels.png'),
//                       ),
//                       ImageIcon(AssetImage('assets/icons/tag.png')),
//                     ],
//                   ),
//                 ),
//                 GridPostsState(uid: currentUser!.uid),
//               ],
//             ),
//           ),
//           bottomNavigationBar: Container(
//               child: Row(
//             children: [
//               Spacer(),
//               ElevatedButton(
//                 onPressed: () => getImage(ref),
//                 child: Text('Select Image'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (selectedImageUrl != null && selectedImageUrl.isNotEmpty) {
//                     await ref
//                         .read(postNotifierProvider(currentUser!.uid).notifier)
//                         .addPost("", currentUser!.uid, selectedImageUrl);

//                     ref.read(selectedImageUrlProvider.notifier).state = null;

//                     print('Post added successfully.');
//                   } else {
//                     print('No image selected.');
//                   }
//                 },
//                 child: Text('Add Post'),
//               ),
//               Spacer()
//             ],
//           ))),
//     );
//   }
// }

// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
// import 'package:instagram_planner/profile/presentation/post_provider.dart';
// import 'menu_page.dart';
// import 'grid_widget.dart';
// import 'profile_pict.dart';
// import '../data/post_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_planner/authentification/data/auth_service.dart';
// import 'bio_profile.dart';
// import 'profile_number.dart';
// import 'story_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:reorderable_grid_view/reorderable_grid_view.dart';

// class ProfilePage extends ConsumerWidget {
//   final List<PostModel> postModel = [];
//   final picker = ImagePicker();
//   var currentUser = FirebaseAuth.instance.currentUser;
//   final selectedImageUrlProvider = StateProvider<String?>((ref) => null);

//   Future<void> getImage(WidgetRef ref) async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null && currentUser != null) {
//       print('Picked file path: ${pickedFile.path}');
//       ref.read(selectedImageUrlProvider.notifier).state = pickedFile.path;
//     } else {
//       print('No image selected.');
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedImageUrl = ref.watch(selectedImageUrlProvider);

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: ListView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         StreamBuilder(
//                           stream: FirebaseFirestore.instance
//                               .collection('users')
//                               .doc(currentUser?.uid)
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return CircularProgressIndicator();
//                             } else if (snapshot.hasError) {
//                               return Text('Error');
//                             } else if (snapshot.hasData &&
//                                 snapshot.data?.data() != null) {
//                               var userDocument =
//                                   snapshot.data!.data() as Map<String, dynamic>;
//                               return Text(
//                                 userDocument["username"],
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               );
//                             } else {
//                               return Text(
//                                 'No Data',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               );
//                             }
//                           },
//                         ),
//                         const SizedBox(width: 5),
//                         Image.asset(
//                           'assets/icons/arrow_down.png',
//                           color: Colors.white,
//                           height: 12,
//                           width: 12,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(
//                           'assets/icons/threads.png',
//                           height: 23,
//                           width: 23,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(width: 30),
//                         Image.asset(
//                           'assets/icons/more.png',
//                           height: 23,
//                           width: 23,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(width: 30),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const MenuPage()),
//                             );
//                           },
//                           child: Image.asset(
//                             'assets/icons/menu.png',
//                             height: 23,
//                             width: 23,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 35),
//               const Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ProfilePic(),
//                   ProfileNumber(
//                     amount: '50',
//                     name: 'posts',
//                   ),
//                   ProfileNumber(
//                     amount: '302',
//                     name: 'followers',
//                   ),
//                   ProfileNumber(
//                     amount: '301',
//                     name: 'following',
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 5),
//               const BioProfile(),
//               const SizedBox(height: 12),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 35,
//                       width: 150,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(106, 158, 158, 158),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Center(
//                         child: Text(
//                           'Edit profile',
//                           style: TextStyle(color: Colors.white, fontSize: 17),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 35,
//                       width: 170,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(106, 158, 158, 158),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Center(
//                         child: Text(
//                           'Share profile',
//                           style: TextStyle(color: Colors.white, fontSize: 17),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 35,
//                       width: 45,
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(106, 158, 158, 158),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: const Center(
//                         child: ImageIcon(
//                           AssetImage('assets/icons/invite.png'),
//                           size: 17,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     Story(
//                       image: '123',
//                       title: 'Lombok',
//                     ),
//                     SizedBox(width: 15),
//                     Story(
//                       image: '124',
//                       title: 'Bali',
//                     ),
//                     SizedBox(width: 15),
//                     Story(
//                       image: '5',
//                       title: 'Jakarta',
//                     ),
//                     SizedBox(width: 15),
//                     Story(
//                       image: '126',
//                       title: 'Afrika',
//                     ),
//                     SizedBox(width: 15),
//                     Story(
//                       image: '127',
//                       title: 'Japan',
//                     ),
//                     SizedBox(width: 15),
//                     Story(
//                       image: '100',
//                       title: 'Saudi Arabia',
//                     ),
//                     SizedBox(width: 15),
//                     Story(
//                       image: '129',
//                       title: 'Turki',
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: TabBar(
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   unselectedLabelColor: Colors.grey,
//                   labelColor: Colors.white,
//                   indicatorColor: Colors.white,
//                   dividerColor: Color.fromARGB(80, 158, 158, 158),
//                   tabs: [
//                     ImageIcon(AssetImage('assets/icons/grid2.png')),
//                     ImageIcon(
//                       AssetImage('assets/icons/reels.png'),
//                     ),
//                     ImageIcon(AssetImage('assets/icons/tag.png')),
//                   ],
//                 ),
//               ),
//               GridPostsState(uid: currentUser!.uid),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           child: Row(
//             children: [
//               Spacer(),
//               ElevatedButton(
//                 onPressed: () => getImage(ref),
//                 child: Text('Select Image'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   final selectedImageUrl = ref.read(selectedImageUrlProvider);
//                   print('Selected image URL: $selectedImageUrl');
//                   if (selectedImageUrl != null && selectedImageUrl.isNotEmpty) {
//                     await ref
//                         .read(postNotifierProvider(currentUser!.uid).notifier)
//                         .addPost(currentUser!.uid, selectedImageUrl, "");

//                     ref.read(selectedImageUrlProvider.notifier).state = null;
//                     print('Post added successfully.');
//                   } else {
//                     print('No image selected.');
//                   }
//                 },
//                 child: Text('Add Post'),
//               ),
//               Spacer()
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/presentation/auth_provider.dart';
import 'package:instagram_planner/profile/presentation/post_provider.dart';
import 'package:instagram_planner/providers.dart';
import 'menu_page.dart';
import 'grid_widget.dart';
import 'profile_pict.dart';
import '../data/post_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_planner/authentification/data/auth_service.dart';
import 'bio_profile.dart';
import 'profile_number.dart';
import 'story_widget.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class ProfilePage extends ConsumerWidget {
  final picker = ImagePicker();
  //User reprezentujący aktualnie zalogowanego użytkownika (zeby miec uid)
  var currentUser = FirebaseAuth.instance.currentUser;
  final selectedImageUrlProvider = StateProvider<String?>((ref) => null);
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  // Future<void> pickImage(WidgetRef ref) async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null && currentUser != null && currentUser!.uid != null) {
  //     final newPost = PostModel(
  //         id: '',
  //         image: pickedFile.path,
  //         useruid: currentUser!.uid,
  //         description: "",
  //         order: 0);
  //     await ref
  //         .read(postNotifierProvider(currentUser!.uid).notifier)
  //         //.addPost(currentUser!.uid, pickedFile.path, "");
  //         .addPost(PostModel(
  //             image: pickedFile.path,
  //             useruid: currentUser!.uid,
  //             description: ''));
  //   }
  // }

  Future<void> getImage(WidgetRef ref) async {
    // Mobile platform
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && currentUser != null && currentUser!.uid != null) {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/${path.basename(pickedFile.path)}');

      // dodawanie pliku do storage
      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(File(pickedFile.path));

      // czekanie na zakończenie dodawania pliku
      await uploadTask.whenComplete(() => null);
      String returnURL = await storageReference.getDownloadURL();

      final newPost = PostModel(
          id: '',
          image: returnURL,
          useruid: currentUser!.uid,
          description: "",
          order: 0);
      print("URL:$returnURL");
      await ref.read(postNotifierProvider(currentUser!.uid).notifier).addPost(
          PostModel(
              image: returnURL, useruid: currentUser!.uid, description: ''));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedImageUrl = ref.watch(selectedImageUrlProvider);
    final userProvider = ref.watch(userNotifierProvider(currentUser!.uid));
    //final authState = ref.watch(authProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          // StreamBuilder(
                          //   stream: FirebaseFirestore.instance
                          //       .collection('users')
                          //       .doc(currentUser?.uid)
                          //       .snapshots(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.waiting) {
                          //       return CircularProgressIndicator();
                          //     } else if (snapshot.hasError) {
                          //       return Text('Error');
                          //     } else if (snapshot.hasData &&
                          //         snapshot.data?.data() != null) {
                          //       var userDocument = snapshot.data!.data()
                          //           as Map<String, dynamic>;
                          //       return Text(
                          //         userDocument["username"],
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 22,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       );
                          //     } else {
                          //       return Text(
                          //         'No Data',
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 22,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       );
                          //     }
                          //   },
                          // ),
                          Text(
                            userProvider.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/icons/arrow_down.png',
                            color: Colors.white,
                            height: 12,
                            width: 12,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/icons/threads.png',
                            height: 23,
                            width: 23,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          child: Image.asset(
                            'assets/icons/more.png',
                            height: 23,
                            width: 23,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPage(
                                        uid: currentUser!.uid,
                                      )),
                            );
                          },
                          child: Image.asset(
                            'assets/icons/menu.png',
                            height: 23,
                            width: 23,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfilePic(
                    uid: currentUser!.uid,
                  ),
                  ProfileNumber(
                    amount: '50',
                    name: 'posts',
                  ),
                  ProfileNumber(
                    amount: '302',
                    name: 'followers',
                  ),
                  ProfileNumber(
                    amount: '301',
                    name: 'following',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              BioProfile(uid: currentUser!.uid),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(106, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Edit profile',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 170,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(106, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Share profile',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 45,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(106, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: ImageIcon(
                        AssetImage('assets/icons/invite.png'),
                        size: 17,
                        color: Colors.white,
                      )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Story(
                      image: '124',
                      title: 'Bali',
                    ),
                    SizedBox(width: 25),
                    Story(
                      image: '5',
                      title: 'Jakarta',
                    ),
                    SizedBox(width: 25),
                    Story(
                      image: '126',
                      title: 'Afrika',
                    ),
                    SizedBox(width: 25),
                    Story(
                      image: '127',
                      title: 'Japan',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                height: 50,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  dividerColor: Color.fromARGB(80, 158, 158, 158),
                  tabs: [
                    ImageIcon(AssetImage('assets/icons/grid2.png')),
                    ImageIcon(
                      AssetImage('assets/icons/reels.png'),
                    ),
                    ImageIcon(AssetImage('assets/icons/tag.png')),
                  ],
                ),
              ),
              GridPostsState(uid: currentUser!.uid),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            children: [
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () => getImage(ref),
                child: Text(
                  'Select Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () async {
              //     if (selectedImageUrl != null && selectedImageUrl.isNotEmpty) {
              //       await ref
              //           .read(postNotifierProvider(currentUser!.uid).notifier)
              //           .addPost(PostModel(
              //               image: selectedImageUrl,
              //               useruid: currentUser!.uid,
              //               description: ''));
              //       //.addPost("", currentUser!.uid, selectedImageUrl);
              //       ref.read(selectedImageUrlProvider.notifier).state = null;
              //       print('Post added successfully.');
              //     } else {
              //       print('No image selected.');
              //     }
              //   },
              //   child: Text('Add Post'),
              // ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
