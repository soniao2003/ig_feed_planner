import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/authentification/data/user_model.dart';
import 'package:instagram_planner/authentification/presentation/login_page.dart';
import 'package:instagram_planner/providers.dart';
import 'package:instagram_planner/user/data/UserService.dart';
import 'package:instagram_planner/user/presentation/edituser_page.dart';
import 'package:instagram_planner/user/presentation/single_post_page.dart';

class MenuPage extends ConsumerWidget {
  final String uid;

  MenuPage({required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userState = ref.watch(userProvider);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 36, 35, 34),
        body: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'MENU',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: GestureDetector(
                      onTap: () async {
                        UserModel user = await userState.getUser(uid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserPage(user: user, uid: uid)),
                        );
                      },
                      child: Card(
                          color: Colors.grey,
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Edit profile',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ])))),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: GestureDetector(
                      onTap: () {
                        print('tapped');
                      },
                      child: Card(
                          color: Colors.grey,
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(children: [
                                Icon(
                                  Icons.auto_awesome_sharp,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Inspirations',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ])))),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: GestureDetector(
                      onTap: () {
                        ref.read(authProvider.notifier).signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Card(
                          color: Colors.grey,
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ])))),
                ),
              ],
            )));
  }
}
