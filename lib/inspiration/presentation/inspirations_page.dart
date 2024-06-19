import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_planner/inspiration/presentation/inspiration_single_page.dart';

class InspoPage extends StatelessWidget {
  const InspoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 35, 34),
        title: Text('Inspirations', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 35, 34),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose category',
              style: TextStyle(
                  fontSize: (20), color: Color.fromARGB(255, 255, 7, 102)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  print('tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InspirationsPage(category: 'general'),
                    ),
                  );
                },
                child: Card(
                  color: Colors.amber,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('General',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  print('tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InspirationsPage(category: 'summer'),
                    ),
                  );
                },
                child: Card(
                  color: Colors.amber,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Summer',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  print('tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InspirationsPage(category: 'friends'),
                    ),
                  );
                },
                child: Card(
                  color: Colors.amber,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Friends',
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
