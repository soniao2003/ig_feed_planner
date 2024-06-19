// import 'package:flutter/material.dart';

// class ProfilePic extends StatelessWidget {
//   const ProfilePic({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       height: 80,
//       width: 80,
//       decoration: BoxDecoration(
//         color: Colors.amber,
//         borderRadius: BorderRadius.circular(60),
//         gradient: const LinearGradient(
//             begin: Alignment.centerRight,
//             end: Alignment.bottomLeft,
//             colors: [Color(0xffC71585), Colors.amber]),
//       ),
//       child: Stack(
//         children: [
//           Container(
//             height: 75,
//             width: 75,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(60),
//               border: Border.all(color: Colors.black, width: 2),
//               image:  DecorationImage(
//                   image: AssetImage('assets/images/avatar.jpg'),
//                   fit: BoxFit.cover),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/providers.dart';

class ProfilePic extends ConsumerWidget {
  //const ProfilePic({super.key});
  final String uid;

  ProfilePic({required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userProvider = ref.watch(userNotifierProvider(uid));

    return Container(
      alignment: Alignment.center,
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(60),
        gradient: const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xffC71585), Colors.amber],
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.black, width: 2),
              image: DecorationImage(
                //image: NetworkImage(userProvider.avatar),
                image: AssetImage('assets/icons/grid.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // StreamBuilder<DocumentSnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection('users')
          //       .doc(currentUser?.uid)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text('Error');
          //     } else if (snapshot.hasData && snapshot.data?.data() != null) {
          //       var userDocument =
          //           snapshot.data!.data() as Map<String, dynamic>;
          //       return Container(
          //         height: 75,
          //         width: 75,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(60),
          //           border: Border.all(color: Colors.black, width: 2),
          //           image: DecorationImage(
          //             image: NetworkImage(userDocument['avatar']),
          //             fit: BoxFit.cover,
          //           ),
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
        ],
      ),
    );
  }
}
