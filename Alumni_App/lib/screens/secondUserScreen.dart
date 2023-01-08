import 'package:alumni/modals.dart/universalVariables.dart';
import 'package:alumni/resources/firebaseRepos.dart';
import 'package:alumni/screens/auxScreens/mainChatScreen.dart';
import 'package:alumni/screens/auxScreens/postCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SecondUserProfilePage extends StatefulWidget {
  final DocumentSnapshot qds;
  SecondUserProfilePage(this.qds);
  @override
  _SecondUserProfilePageState createState() => _SecondUserProfilePageState(qds);
}

class _SecondUserProfilePageState extends State<SecondUserProfilePage> {
  List<QueryDocumentSnapshot> _list = [];
  FirebaseRepos _repositories = new FirebaseRepos();

  String SubAdmin;
  String SubAdmin2;
  DocumentSnapshot userData;
  User currentUser;

  initState() {

    currentUser = _repository.getCurrentUser();
    SubAdmin2=widget.qds.data()['SubAdmin'].toString().toUpperCase();
    _repositories.getCurrentUserData().then((data) {
      setState(() {
       userData = data;
       SubAdmin=userData.data()['SubAdmin'].toString().toUpperCase();
      });});
    _repositories
        .getUserPosts(widget.qds.data()['uid'])
        .then((List<QueryDocumentSnapshot> list) {
      setState(() {
        _list = list;
      });
    });

    super.initState();
  }

  QueryDocumentSnapshot qds;
  _SecondUserProfilePageState(this.qds);
  FirebaseRepos _repository = new FirebaseRepos();
  FirebaseRepos _repositorySubAdmin = new FirebaseRepos();
  Future _showDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete User"),
          content: Text("Are you sure to delete the User?"),
          actions: [
            MaterialButton(
                onPressed: () {
                  _repository.deleteUser(qds.data()['uid']).then((value) {
                    setState(() {
                      qds = null;
                    });

                    Navigator.of(context).pop();
                  });
                },
                child: Text("Yes")),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No")),
          ],
        );
      },
    );
  }
  Future _showDialogSubAdmin() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sub Admin"),
          content: Text("Are you sure to add or Remove Sub Admin?"),
          actions: [
            MaterialButton(
                onPressed: () {
                  _repositorySubAdmin.updateUserInfo2(qds.data()['uid'], 'SUB').then((value) {
                    setState(() {

                    });

                    Navigator.of(context).pop();
                  });
                },
                child: Text("Yes")),
            MaterialButton(
                onPressed: () {
                  _repositorySubAdmin.updateUserInfo2(qds.data()['uid'], 'UNSUB').then((value) {
                    setState(() {

                    });

                    Navigator.of(context).pop();
                  });
                },
                child: Text("REMOVE")),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No")),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    _appbar() {
      return AppBar(
        title: Text(widget.qds.data()['rollNumber']),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xff272c35),
        actions: [
          Container(
              child:(currentUser.uid=='QUyaqGdW2SOPWUCgz9tkYWcBQL02' ||  SubAdmin=='SUB')
                  ?
              Container(
                  child:(currentUser.uid=='QUyaqGdW2SOPWUCgz9tkYWcBQL02' )?
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.person_add_alt_1_sharp, color: Colors.white),
                          onPressed: () {
                            _showDialogSubAdmin();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () {
                            _showDialog();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(widget.qds),
                              ),
                            );

                          },
                        ),


                      ],
                    ),
                  ):
                  Container(
                    child: Row(
                      children: [

                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(widget.qds),
                              ),
                            );

                          },
                        ),


                      ],
                    ),
                  )

              )
                  : IconButton(
                icon: Icon(Icons.chat, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(widget.qds),
                    ),
                  );

                },
              ),
          ),
        ],
      );
    }

    _firstContainer() {
      return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Shimmer.fromColors(
                baseColor: widget.qds.data()['tag'].toString().toUpperCase() ==
                        "STUDENT"
                    ? Colors.lightBlue
                    : Colors.red,
                highlightColor: Colors.white,
                child: Text(
                  "${widget.qds.data()['tag'].toString().toUpperCase()} ${widget.qds.data()['course'].toString().toUpperCase()}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "${widget.qds.data()['startingYear'].toString().toUpperCase()} - ${widget.qds.data()['endingYear'].toString().toUpperCase()}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.qds.data()['name'].toString().toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.qds.data()['Skill'].toString().toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),

      Container(
      child:(SubAdmin2=='SUB' )
      ?
      Container(
        child: Column(
          children: [
            Container(
                child:(widget.qds.data()['uid'].toString()=='QUyaqGdW2SOPWUCgz9tkYWcBQL02' )
                    ?
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'ADMIN',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ):Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'SubAdmin',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ):Container()),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                widget.qds.data()['branch'].toString(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }

    _secondContainer() {
      return Expanded(
        child: Container(
          child: _list.length == 0
              ? Container(
                  child: Center(
                    child: Text(
                      "No posts Yet....",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              : _widgetContainer(),
        ),
      );
    }

    return Scaffold(
      appBar: _appbar(),
      backgroundColor: UniversalVariables.separatorColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _firstContainer(),
            _secondContainer(),
          ],
        ),
      ),
    );
  }

  _widgetContainer() {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) => PostCard(_list[index]),
        itemCount: _list.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
      ),
    );
  }
}
