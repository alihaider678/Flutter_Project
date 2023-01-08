import 'dart:io';
import 'package:alumni/modals.dart/posts.dart';
import 'package:alumni/modals.dart/universalVariables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../resources/firebaseRepos.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}


class _AddPostState extends State<AddPost> {

  User currentUser;
  File _image;
  ImagePicker _picker;
  TextEditingController _textController = new TextEditingController();
  FirebaseRepos _repository = FirebaseRepos();
  bool shouldIRotate;
  String imgUrl;
  String SubAdmin;
  DocumentSnapshot userData;
  var uid;

  initState() {
    currentUser = _repository.getCurrentUser();
    _repository.getCurrentUserData().then((data) {
      setState(() {
        userData = data;
        SubAdmin=userData.data()['SubAdmin'].toString().toUpperCase();
      });});
    _picker = ImagePicker();
    shouldIRotate = false;
    uid = Uuid();
    super.initState();
  }

  Future getImageFromCamera() async {
    final _pickedImage = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      if (_pickedImage != null) _image = File(_pickedImage.path);
    });
  }

  Future getImageFromGallery() async {
    final _pickedImage = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (_pickedImage != null) _image = File(_pickedImage.path);
    });
  }

  Future _showDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select image"),
            content: Text("Choose image from"),
            actions: [
              MaterialButton(
                  onPressed: () {
                    getImageFromCamera()
                        .then((value) => Navigator.pop(context));
                  },
                  child: Text("Camera")),
              MaterialButton(
                  onPressed: () {
                    getImageFromGallery()
                        .then((value) => Navigator.pop(context));
                  },
                  child: Text("Gallery")),
            ],
          );
        });
  }

  Future _showUploadingDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Uploading post"),
          content: Container(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  _appbar() {
    return AppBar(
      title: Text("Create Post", style: TextStyle(color: Colors.black),),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              if (_image == null &&
                  (_textController.text.trim().length == 0 ||
                      _textController.text.length == 0)) {
              } else {
                setState(() {
                  _showUploadingDialog();
                });
                _repository.addImageToDB(_image).then(
                  (String _imageUrl) {
                    setState(() {
                      imgUrl = _imageUrl;
                    });
                    _repository
                        .getCurrentUserData()
                        .then((DocumentSnapshot userData) {
                      Map<String, dynamic> ud = userData.data();
                      User _currentUser = _repository.getCurrentUser();
                      String uidd = uid.v1().toString();

                      Post _myPost = new Post(
                        imageUrl: _imageUrl,
                        likes: [],
                        text: _textController.text,
                        uid: _currentUser.uid,
                        date: DateTime.now(),
                        branch: ud['branch'],
                        course: ud['course'],
                        name: ud['name'],
                        id: uidd,
                        tag: ud['tag'],
                      );

                      _repository.addPostDataToDB(_myPost, uidd).then((value) {
                        setState(() {
                          Navigator.of(context).pop();
                          _image = null;
                          _textController.clear();
                        });
                      });
                    });
                  },
                );
              }
            },
          ),
        )
      ],
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
    );
  }

  Widget imageContainer() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget textContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      //
      child: TextField(
        controller: _textController,
        maxLines: 10,
        maxLength: 100,
        //maxLengthEnforcement: true,
        decoration: InputDecoration(
          hintText: "Write something about your post..",
          helperStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color(0xff2b9ed4))),
        ),
      ),
      //
    );
  }

  Widget buttonContainer() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 10),
      child: MaterialButton(
        onPressed: () {
          _showDialog();
        },
        child: Text("Add image",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        color: Color(0xff2b9ed4),
      ),
    );
  }
adminpost()
{
  return SingleChildScrollView(
    child: Column(
      children: [

        if (_image != null) imageContainer(),
        textContainer(),
        if (_image == null) buttonContainer(),
      ],
    ),
  );
}
  notpost()
  {
    return Container(
      margin: EdgeInsets.only(
          left: 10,
          right:10,
          bottom: 10
      ),
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text('Only Admin Can Make Posts', textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent),
              ),

            ),
          ),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
         Column(
             children: [
               (currentUser.uid=='5kF7hNZmFoNbYdTQaHv9qSwOyYS2'||  SubAdmin=='SUB')
                   ? adminpost()
                   : notpost(),
             ],
         ),
          // if (shouldIRotate == true)
          //   Container(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   )
        ],
      ),
    );
  }
}
