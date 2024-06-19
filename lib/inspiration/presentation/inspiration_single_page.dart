import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_planner/providers.dart';

class InspirationsPage extends ConsumerWidget {
  final String category;

  InspirationsPage({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inspolist = ref
        .read(inspoNotifierProvider(category).notifier)
        .fetchInspirations(category);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 44, 44),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 45, 44, 44),
          title: Text(
            'Inspirations Page',
            style: TextStyle(color: Colors.white),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List>(
                future: inspolist, // your Future<List>
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 255, 7, 102),
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Text(
                                    snapshot.data?[index].caption ?? '',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
