import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/providers.dart';
import 'package:instagram_planner/user/data/UserService.dart';

class BioProfile extends ConsumerWidget {
  final String uid;
  const BioProfile({
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(userNotifierProvider(uid));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userProvider.name,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            userProvider.bio,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Row(
          //     children: [
          //       ImageIcon(
          //         const AssetImage(
          //           'assets/icons/link.png',
          //         ),
          //         color: Colors.blueGrey.shade200,
          //         size: 17,
          //       ),
          //       const SizedBox(width: 5),
          //       Text(
          //         'youtube.com/@manshurdev',
          //         style:
          //             TextStyle(color: Colors.blueGrey.shade200, fontSize: 16),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
