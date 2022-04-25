import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:pw_assingment/widgets/user.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User>? users;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final dio = Dio();
      const url = 'https://my-json-server.typicode.com/easygautam/data/users';
      final response = await dio.get(url);
      users = List<User>.from(response.data.map((x) => User.fromMap(x)));
    } catch (_) {
      users = [];
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Robby Darling',
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(spreadRadius: 2.3, blurRadius: 8, color: Colors.grey)
            ],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(19.0)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.indigo.shade900, Colors.pink.shade900]),
          ),
        ),
      ),
      body: Center(
        child: loading ? CircularProgressIndicator() : buildUsers(users!),
      ),
    );
  }

  Widget buildUsers(List<User> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 25),
            child: Card(
              shadowColor: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 12.0, 12.0, 4.0),
                            child: Text(
                              user.name,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color.fromARGB(188, 40, 25, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 4.0,0, 4),
                            child: Row(
                              children: [
                                Text(
                                  user.subjects[0],
                                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                                ),

                                Text(
                                  ' • ',
                                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                                ),
                                Text(
                                  user.qualification[0],
                                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold,color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 3.0, 12.0, 12.0),
                              child: TextButton(
                                child: Text('View More',),
                                onPressed: () {},
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  padding: MaterialStateProperty.resolveWith<
                                      EdgeInsetsGeometry>(
                                    (Set<MaterialState> states) {
                                      return EdgeInsets.only(
                                          left: 25, right: 25);
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(188, 40, 25, 255),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.purple.shade50
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: user.profileImage,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          );
        },
      );
}
